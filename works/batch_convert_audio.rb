require 'streamio-ffmpeg'
aif=Dir["/Volumes/A002/Samples/**/*.aif"]
caf=Dir["/Volumes/A002/Samples/**/*.caf"]
mp3=Dir["/Volumes/A002/Samples/**/*.mp3"]
mp4=Dir["/Volumes/A002/Samples/**/*.mp4"]
m4a=Dir["/Volumes/A002/Samples/**/*.m4a"]
audio_files=aif.concat(caf).concat(mp3).concat(mp4).concat(m4a)
audio_files.each do |audio|
  path=File.dirname(audio)
  filename=File.basename(audio, ".*") 
    movie = FFMPEG::Movie.new(audio)
   movie.transcode(path+"/"+filename+".wav",)
end

