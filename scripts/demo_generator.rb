
demo_scripts=Dir["www/public/medias/rubies/examples**/*.rb"]
scripts_list=[]
demo_scripts.each do |script_name|
  #scripts_list << "require '.#{script_name}'"
  script_path=".#{script_name}"
  script_name= File.basename(script_name, '.rb')
  unless script_name== "!demos"
    scripts_list << "#{script_name}: '#{script_path}'"
  end
end
#file="demos={"+scripts_list.join(",\n")+"}"

file=<<STRDELIM
demos={#{scripts_list.join(",\n")}}
demos
STRDELIM
File.write("www/public/medias/rubies/examples/!demos.rb", file)
