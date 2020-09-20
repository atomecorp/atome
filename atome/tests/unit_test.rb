#class Atome
#  def initialize (param = nil)
#    if param != nil
#      @atome = param
#    else
#      @atome = {}
#    end
#  end
#
#  props = [:id, :x, :y, :width, :height, :color, :border, :shadow]
#  #these props are not only props for the Atome but they are used created methods form this list
#  prop_list = []
#  # for more convenience we add pluralisation to all props and methods as well as assignation for all methods adding "=" to all props methods
#  props.each do |object|
#    prop_list << object
#    prop_list << (object.to_s + "s").to_sym
#    prop_list << (object.to_s + "=").to_sym
#  end
#
#  # we define all Atome's methods below
#  prop_list.each do |function|
#    define_method(function) do |value = nil|
#      #we remove the "=" sign to create the method
#      function = function.to_s.chomp("=").to_sym
#      if value
#        # a parameter is passed we set up a setter
#        if function.to_s.end_with?("s")
#          puts "ai aia i"
#        end
#        if value.class == Hash
#          method = value.keys[0]
#          property = function
#          value = value[method]
#          self.send(method, ({property => value}))
#        else
#          new_prop = {:value => value}
#          @atome[function] = Atome.new(new_prop)
#        end
#        return self
#      else
#        #no params are passed: we set up a  getter!!
#        if function.to_s.end_with?("s")
#          function = function.to_s.chomp("s")
#          collected_prop = []
#          @atome.each do |prop, value|
#            if prop.to_s.start_with?(function)
#              collected_prop << value
#            end
#          end
#          return collected_prop
#        else
#          return @atome[function]
#
#        end
#
#      end
#    end
#  end
#
#  # SAGED methods here (Set Add Get Exchange Delete)
#
#  def set prop = nil
#    prop_to_set = prop.keys[0]
#    value = prop[prop_to_set]
#    @atome.each do |key, value|
#      if key.to_s.start_with?(prop_to_set.to_s)
#        @atome.delete(key)
#      end
#    end
#    new_prop = {:value => value}
#    @atome[prop_to_set] = Atome.new(new_prop)
#  end
#
#  def add prop = nil
#    if prop
#      nb_of_prop_found = 0
#      requested_prop = prop.keys[0].to_s
#      value = prop[prop.keys[0]]
#      @atome.keys.each do |prop_found|
#        prop_found = prop_found.to_s
#        if prop_found.start_with?(requested_prop)
#          nb_of_prop_found = nb_of_prop_found + 1
#        end
#      end
#      requested_prop = (requested_prop + "_#{nb_of_prop_found}").to_sym
#      new_prop = {:value => value}
#      @atome[requested_prop] = Atome.new(new_prop)
#    end
#    return self
#  end
#
#  def get prop = nil
#
#  end
#
#  def erase prop = nil
#
#  end
#
#  # Various utils methods here
#  def atome
#    return @atome
#  end
#
#  def length
#    return @atome.length
#  end
#
#  def each(&block)
#    @atome.each(&block)
#  end
#
#  def to_hash
#    self.to_enum(self)
#  end
#
#  def to_s
#    return @atome.to_s
#  end
#
#end
#
#
################### replace the abovewith q require ##########@
#def test_results filename, code, reaet = "a"
#  results = []
#  begin
#    eval code
#    results << "Sucess : " + filename + "\n"
#
#  rescue Exception => e
#    e.backtrace.map { |x|
#      error = x.match(/^(.+?):(\d+)(|:in `(.+)')$/);
#      [$1, $2, $4]
#      results << filename + " : error : " + error.to_s
#    }
#  end
#  results = results.join("\n")
#  File.write('./tests/results.txt', results, mode: reaet)
#
#end
#
#def tester mode = :unit, folder = "tests"
#  files_collected = []
#  concatenate = {}
#  Dir.glob(folder + '/**/*.rb').select do |rb_file|
#    files_collected << rb_file
#  end
#
#  files_collected = files_collected.sort()
#
#  files_collected.each do |rb_file|
#    File.file? rb_file
#    file = File.open(rb_file)
#    file_data = file.read
#    concatenate[rb_file] = file_data
#  end
#
#  if mode == :unit
#
#    concatenate.each_with_index do |(filename, code), index|
#      filename = File.basename(filename, '.rb')
#      if index == 0
#        test_results(filename, code, "w")
#      else
#        test_results(filename, code)
#      end
#
#    end
#
#  elsif mode == :cumulate
#    all_files = []
#    concatenate.each do |filename, code|
#      all_files << code
#    end
#    all_files = all_files.join("\n")
#    test_results("allfiles", all_files, "w")
#  end
#
#
#end
#
#tester