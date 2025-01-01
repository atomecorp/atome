# frozen_string_literal: true


def contact_template
{ id: :humans, role: nil, date: { companies: [], project: {}, events: {}, last_name: nil, first_name: nil ,
                                  emails: { home: nil }, phones: {}, address: {}, groups: [] } }
end


element({id: :testing, data: contact_template})
# grab(:testing).data(contact_template)


wait 2 do
  grab(:testing).data
end

def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": []
}
end

########## new tests
# puts Universe.particle_list
# puts Universe.particle_list.keys
# puts Universe.atome_list
# puts Universe.molecule_list
# puts Universe.preset_list
atome_object_list= {
  particles: Universe.particle_list.keys,
  atomes: Universe.atome_list,
  molecules: Universe.molecule_list,
  preset: Universe.preset_list,

}



#
# a= Universe.apis[:particles][:left][:example]
#
# puts a
# eval(a)
# puts atome_object_list
#  Universe.apis do |p|
#    puts "===> #{p}"
#
#  #   [:atomes][:color][:aim]
#
#  end

# def create_file_link(file_path, display_text)


  link = text({
                data: 'hello',
                color: :orange,
                cursor: :pointer
              })
  link.touch(:tap) do
    file_path = '../src/medias/utils/examples.json'
    A.read(file_path) do |data|
      hash = JSON.parse(data)

      text hash.class
# my_hash = JSON.parse(a) # convert to Ruby hash
#       text a.class
      # puts "file content  :\n #{data}"
    end
    # Universe.apis do |apis_list|
    #   # puts "===> #{apis_list[:atomes][:color][:aim]}"
    #   puts "===> #{apis_list.class}"
    # end
     # apis do |p|
     #   puts "===> #{p}"
     #
     # #   [:atomes][:color][:aim]
     #
     # end

  end
# a= "{hello: :salut , other:'ok ca roule'}"
#
# hash = { name: "Alice", age: 25, city: "Paris" }
# json = hash.to_json
# puts json
# b=eval(a).to_json
#
# alert b.class
#   # link
# # end
#   # create_file_link('../application/examples/blur.rb', 'Cliquez ici pour ouvrir le fichier')
#
#
# # async function loadTextFile() {
# #   try {
# #     const response = await fetch('./monfichier.txt');
# #     if (!response.ok) {
# #       throw new Error(`Erreur: ${response.statusText}`);
# #     }
# #     const text = await response.text();
# #     console.log(text);
# #     return text;
# #     } catch (error) {
# #       console.error('Erreur lors du chargement du fichier texte :', error);
# #     }
# #     }