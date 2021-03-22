# demo list  generator
demo_scripts=Dir["www/public/medias/rubies/examples**/*.rb"]
scripts_list=[]
demo_scripts.each do |demo_name|
  script_name= File.basename(demo_name, '.rb')
  demo_name="./medias/rubies/examples/"+File.basename(demo_name)
  script_path=demo_name

  unless script_name== "!demos"
    scripts_list << "#{script_name}: '#{script_path}'"
  end
end
file=<<STRDELIM
{#{scripts_list.join(",\n")}}
STRDELIM
File.write("www/public/medias/rubies/examples/!demos.rb", file)