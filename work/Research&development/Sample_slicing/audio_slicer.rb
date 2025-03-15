#!/usr/bin/env ruby
require 'optparse'
require 'fileutils'
require 'tempfile'
require 'json'

class AudioSlicer
  attr_reader :input_path, :output_dir, :threshold, :equal_segments, :segment_count

  def initialize(options)
	@input_path = options[:input_path]
	@output_dir = options[:output_dir] || 'treated'
	@threshold = options[:threshold] || 0.01
	@equal_segments = options[:equal_segments] || false
	@segment_count = options[:segment_count] || 10
	
	# Ensure main output directory exists
	FileUtils.mkdir_p(@output_dir) unless Dir.exist?(@output_dir)
  end

  def slice
	if File.directory?(@input_path)
	  Dir.glob(File.join(@input_path, '**', '*.{wav,mp3,flac}')).each do |file|
		process_file(file)
	  end
	elsif File.exist?(@input_path)
	  process_file(@input_path)
	else
	  puts "Error: Input path '#{@input_path}' does not exist."
	  exit 1
	end
  end

  private

  def process_file(file)
	@input_file = file
	puts "Processing file: #{@input_file}"
	
	# Create a subdirectory for this specific sample
	base_name = File.basename(@input_file, ".*")
	@sample_dir = File.join(@output_dir, base_name)
	FileUtils.mkdir_p(@sample_dir) unless Dir.exist?(@sample_dir)
	
	# Get file info using ffprobe
	file_info = get_file_info
	if file_info[:duration] <= 0
	  puts "Error: Could not determine file duration or file has zero duration."
	  return
	end

	puts "Audio file: #{@input_file}"
	puts "Output directory: #{@sample_dir}"
	puts "Duration: #{file_info[:duration]} seconds"
	puts "Sample rate: #{file_info[:sample_rate]} Hz"
	puts "Channels: #{file_info[:channels]}"

	if @equal_segments
	  slice_equal_segments(file_info[:duration])
	else
	  slice_at_silence(file_info)
	end
  end

  def get_file_info
	# Use ffprobe to get file information
	cmd = "ffprobe -v quiet -print_format json -show_format -show_streams \"#{@input_file}\""
	output = `#{cmd}`
	begin
	  info = JSON.parse(output)
	  # Find audio stream
	  audio_stream = info["streams"].find { |s| s["codec_type"] == "audio" }
	  if audio_stream.nil?
		puts "Warning: No audio stream found. Using format duration."
		duration = info["format"]["duration"].to_f
		sample_rate = 44100
		channels = 2
	  else
		duration = audio_stream["duration"].to_f
		sample_rate = audio_stream["sample_rate"].to_i
		channels = audio_stream["channels"].to_i
	  end
	  # If duration is still not available, try format duration
	  if duration <= 0 && info["format"] && info["format"]["duration"]
		duration = info["format"]["duration"].to_f
	  end
	  # If still no duration, use soxi as a fallback
	  if duration <= 0
		duration = `soxi -D "#{@input_file}" 2>/dev/null`.strip.to_f
	  end
	  # If still no duration, try ffmpeg directly
	  if duration <= 0
		duration_output = `ffmpeg -i "#{@input_file}" 2>&1 | grep "Duration" | cut -d ' ' -f 4 | sed s/,//`
		if duration_output =~ /(\d+):(\d+):(\d+\.\d+)/
		  hours, minutes, seconds = $1.to_i, $2.to_i, $3.to_f
		  duration = hours * 3600 + minutes * 60 + seconds
		end
	  end
	  return {
		duration: duration,
		sample_rate: sample_rate,
		channels: channels
	  }
	rescue => e
	  puts "Error parsing file info: #{e.message}"
	  puts "Attempting to get duration directly..."
	  # Try a direct method as last resort
	  duration = `ffmpeg -i "#{@input_file}" 2>&1 | grep "Duration" | cut -d ' ' -f 4 | sed s/,//`
	  if duration =~ /(\d+):(\d+):(\d+\.\d+)/
		hours, minutes, seconds = $1.to_i, $2.to_i, $3.to_f
		duration = hours * 3600 + minutes * 60 + seconds
	  else
		duration = 0
	  end
	  return {
		duration: duration.to_f,
		sample_rate: 44100,
		channels: 2
	  }
	end
  end

  def slice_equal_segments(duration)
	puts "Slicing '#{@input_file}' into #{@segment_count} equal segments..."
	segment_duration = duration / @segment_count
	base_name = File.basename(@input_file, ".*")
	extension = File.extname(@input_file)
	
	@segment_count.times do |i|
	  start_time = i * segment_duration
	  output_file = File.join(@sample_dir, "#{base_name}_#{i+1}#{extension}")
	  
	  # Use ffmpeg to extract the segment
	  cmd = "ffmpeg -v quiet -y -i \"#{@input_file}\" -ss #{start_time} -t #{segment_duration} \"#{output_file}\""
	  system(cmd)
	  
	  if File.exist?(output_file) && File.size(output_file) > 0
		puts "Created: #{output_file} (#{segment_duration.round(2)}s)"
	  else
		puts "Failed to create: #{output_file}"
	  end
	end
	
	puts "Done! Created #{@segment_count} equal segments."
  end

  def slice_at_silence(file_info)
	puts "Slicing '#{@input_file}' at silence points (threshold: #{@threshold})..."
	
	# Generate silence detection points using FFmpeg's silencedetect filter
	temp_file = Tempfile.new(['silence_detection', '.txt'])
	temp_path = temp_file.path
	temp_file.close
	
	# Convert threshold to dB (0.01 amplitude is roughly -40dB)
	threshold_db = 20 * Math.log10(@threshold)
	threshold_db = -60 if threshold_db < -60  # Limit minimum threshold
	
	# Run silence detection
	cmd = "ffmpeg -i \"#{@input_file}\" -af silencedetect=noise=#{threshold_db}dB:d=0.3 -f null - 2> \"#{temp_path}\""
	system(cmd)
	
	# Parse silence detection output
	silence_output = File.read(temp_path)
	silence_starts = []
	silence_ends = []
	
	silence_output.each_line do |line|
	  if line =~ /silence_start: (\d+\.\d+)/
		silence_starts << $1.to_f
	  elsif line =~ /silence_end: (\d+\.\d+)/
		silence_ends << $1.to_f
	  end
	end
	
	# Check if we found any silence points
	if silence_starts.empty? || silence_ends.empty?
	  puts "No clear silence points found. Using equal segments method instead."
	  slice_equal_segments(file_info[:duration])
	  return
	end
	
	# Create cutting points at the end of each silence
	cut_points = silence_ends.sort
	
	# Add start point if not starting with silence
	cut_points.unshift(0) unless silence_starts.first == 0
	
	# Add end point
	cut_points << file_info[:duration] unless cut_points.last >= file_info[:duration]
	
	# Remove points that are too close to each other (within 0.5 seconds)
	filtered_points = [cut_points.first]
	cut_points[1..-1].each do |point|
	  if point - filtered_points.last >= 0.5
		filtered_points << point
	  end
	end
	cut_points = filtered_points
	
	puts "Found #{cut_points.length-1} segments using silence detection."
	
	# Extract segments
	base_name = File.basename(@input_file, ".*")
	extension = File.extname(@input_file)
	
	(cut_points.length - 1).times do |i|
	  start_time = cut_points[i]
	  end_time = cut_points[i + 1]
	  segment_duration = end_time - start_time
	  
	  # Skip very short segments
	  next if segment_duration < 0.2
	  
	  output_file = File.join(@sample_dir, "#{base_name}_#{i+1}#{extension}")
	  
	  # Use ffmpeg to extract the segment
	  cmd = "ffmpeg -v quiet -y -i \"#{@input_file}\" -ss #{start_time} -to #{end_time} \"#{output_file}\""
	  system(cmd)
	  
	  if File.exist?(output_file) && File.size(output_file) > 0
		puts "Created: #{output_file} (#{segment_duration.round(2)}s)"
	  else
		puts "Failed to create: #{output_file}"
	  end
	end
	
	puts "Done! Created segments based on silence detection."
	
	# Clean up
	File.delete(temp_path) if File.exist?(temp_path)
  end
end

# Parse command line options
options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: audio_slicer.rb [options] input_path"
  
  opts.on("-o", "--output-dir DIR", "Output directory") do |dir|
	options[:output_dir] = dir
  end
  
  opts.on("-t", "--threshold THRESHOLD", Float, "Silence threshold (default: 0.01)") do |threshold|
	options[:threshold] = threshold
  end
  
  opts.on("-e", "--equal-segments", "Split into equal segments instead of at silence") do
	options[:equal_segments] = true
  end
  
  opts.on("-c", "--segment-count COUNT", Integer, "Number of equal segments (default: 10)") do |count|
	options[:segment_count] = count
  end
  
  opts.on("-h", "--help", "Show this help") do
	puts opts
	exit
  end
end.parse!

if ARGV.empty?
  puts "Error: Input path is required."
  puts "Run with --help for usage information."
  exit 1
end

options[:input_path] = ARGV[0]

# Run the slicer
slicer = AudioSlicer.new(options)
slicer.slice


##usage : 
##slice on silence:
# ruby audio_slicer.rb sample.wav

##Slice a sample in 5 equal pieces :
#  ruby audio_slicer.rb -e -c 5 mon_fichier.wav

## Adjust silence threshold detection :
# ruby audio_slicer.rb -t 0.005 mon_fichier.flac

## Slice all sample in current folder :
# ruby audio_slicer.rb .

# Specify an output folder:
# ruby audio_slicer.rb -o /path/to/folder/mon_fichier.wav