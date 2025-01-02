# frozen_string_literal: true

def contact_template
  { id: :humans, role: nil, date: { companies: [], project: {}, events: {}, last_name: nil, first_name: nil,
                                    emails: { home: nil }, phones: {}, address: {}, groups: [] } }
end

element({ id: :testing, data: contact_template })
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

atome_object_list = {
  particles: Universe.particle_list.keys,
  atomes: Universe.atome_list,
  molecules: Universe.molecule_list,
  preset: Universe.preset_list,

}


link = text({
              data: 'hello',
              color: :orange,
              cursor: :pointer
            })
link.touch(:tap) do
  file_path = '../src/medias/utils/examples/particles/align/example.rb'
  A.read(file_path) do |code|
    puts code
    eval(code)
  end

  A.terminal('pwd') do |data|
    text  "shell response  :\n #{data}"
  end

end
wait 1 do
  # A.terminal('cd ../src/medias/utils/examples;ls') do |data|
  #   text  "shell response  :\n #{data}"
  # end
  #######################################

  def create_symlinks(base_path)
    offset = 0 # Initial offset for positioning elements vertically
    directory_offsets = {} # To track offsets for each directory

    A.terminal("cd #{base_path} && find .") do |data|
      data.each_line do |file|
        file = file.strip # Utilisation de strip sans "!" pour compatibilité avec Opal
        next if file.empty?

        # Découper le chemin pour identifier les répertoires et les fichiers
        parts = file.split("/")

        parts.each_with_index do |part, index|
          next if part.empty? # Ignorer les parties vides

          current_path = parts[0..index].join("/")

          if index < parts.size - 1 # Si c'est un répertoire
            unless directory_offsets.key?(current_path) # Afficher le répertoire s'il n'est pas déjà affiché
              directory_offsets[current_path] = offset

              text({
                     data: part, # Retirer le "/" inutile
                     color: :white,
                     cursor: :pointer,
                     left: index * 20, # Décalage horizontal pour montrer la hiérarchie
                     top: 33 + offset,
                     position: :absolute
                   })

              offset += 20
            end
          elsif index == parts.size - 1 # Si c'est un fichier
            file_path = "#{base_path}/#{file}"

            text({
                   data: part,
                   color: :orange,
                   cursor: :pointer,
                   left: index * 20,
                   top: 33 + offset,
                   position: :absolute
                 }).touch(:tap) do
              A.read(file_path) do |file_data|
                text data: "file content:\\n#{file_data}", top: 9, left: 3
              end
            end

            offset += 20
          end
        end
      end
    end
  end

  # Exemple d'utilisation
  create_symlinks("../src/medias/utils/examples/presets/")


  #######################################

end


