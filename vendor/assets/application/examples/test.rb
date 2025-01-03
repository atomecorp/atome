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

# link = text({
#               data: 'hello',
#               color: :orange,
#               cursor: :pointer
#             })
# link.touch(:tap) do
#   file_path = '../src/medias/utils/examples/particles/align/example.rb'
#   A.read(file_path) do |code|
#     puts code
#     eval(code)
#   end
#
#   A.terminal('pwd') do |data|
#     text "shell response  :\n #{data}"
#   end
#
# end

  # A.terminal('cd ../src/medias/utils/examples;ls') do |data|
  #   text  "shell response  :\n #{data}"
  # end
  ################ code 1 #######################

  # def create_symlinks(base_path)
  #   offset = 0 # Initial offset for positioning elements vertically
  #
  #   A.terminal("cd #{base_path} && find .") do |data|
  #     data.each_line do |file|
  #       file = file.strip # Utilisation de strip sans "!" pour compatibilité avec Opal
  #       next if file.empty?
  #
  #       # Découper le chemin pour identifier les répertoires et les fichiers
  #       parts = file.split("/")
  #
  #       parts.each_with_index do |part, index|
  #         next if part.empty? # Ignorer les parties vides
  #         if index == parts.size - 1 # Afficher uniquement si c'est le dernier élément de la chaîne
  #           file_path = "#{base_path}/#{file}"
  #           text({
  #                  data: part,
  #                  color: :orange,
  #                  cursor: :pointer,
  #                  left: index * 20,
  #                  top: 33 + offset,
  #                  position: :absolute
  #                }).touch(:tap) do
  #             A.read(file_path) do |file_data|
  #               eval(file_data)
  #               text data: "file content:\n#{file_data}", top: 9, left: 3
  #             end
  #           end
  #
  #           offset += 20
  #         end
  #       end
  #     end
  #   end
  # end
#########################@
@a=<<STR
# frozen_string_literal: true

b=circle({left: 333})
b.blur(6)

image(:red_planet)
b2=box({color: {alpha: 0.1, red: 1, green: 0, blue: 0.2}, left: 99, top: 99, width: 99, height: 99})
b2.drag(true)
b2.border({ thickness: 0.3, color: :gray, pattern: :solid })
b2.smooth(12)
b2.shadow({
            invert: true,
            id: :s4,
            left: 2, top: 2, blur: 9,
            # option: :natural,
            red: 0, green: 0, blue: 0, alpha: 0.3
          })

b2.shadow({
            # invert: true,
            id: :s5,
            left: 2, top: 2, blur: 9,
            # option: :natural,
            red: 0, green: 0, blue: 0, alpha: 0.6
          })
b2.blur({affect: :back, value: 15})

def api_infos
  {
    "example": "Purpose of the example",
    "methods_found": [
      "1",
      "2",
      "3",
      "6",
      "blur",
      "border",
      "drag",
      "shadow",
      "smooth"
    ],
    "1": {
      "aim": "The `1` method's purpose is determined by its specific functionality.",
      "usage": "Refer to Atome documentation for detailed usage of `1`."
    },
    "2": {
      "aim": "The `2` method's purpose is determined by its specific functionality.",
      "usage": "Refer to Atome documentation for detailed usage of `2`."
    },
    "3": {
      "aim": "The `3` method's purpose is determined by its specific functionality.",
      "usage": "Refer to Atome documentation for detailed usage of `3`."
    },
    "6": {
      "aim": "The `6` method's purpose is determined by its specific functionality.",
      "usage": "Refer to Atome documentation for detailed usage of `6`."
    },
    "blur": {
      "aim": "The `blur` method's purpose is determined by its specific functionality.",
      "usage": "Refer to Atome documentation for detailed usage of `blur`."
    },
    "border": {
      "aim": "The `border` method's purpose is determined by its specific functionality.",
      "usage": "Refer to Atome documentation for detailed usage of `border`."
    },
    "drag": {
      "aim": "The `drag` method's purpose is determined by its specific functionality.",
      "usage": "Refer to Atome documentation for detailed usage of `drag`."
    },
    "shadow": {
      "aim": "The `shadow` method's purpose is determined by its specific functionality.",
      "usage": "Refer to Atome documentation for detailed usage of `shadow`."
    },
    "smooth": {
      "aim": "Applies smooth transitions or rounded edges to an object.",
      "usage": "Use `smooth(20)` to apply a smooth transition or corner rounding of 20 pixels."
    }
  } 
end

STR
  ################ code to develop #######################

def repair_syntax(input)
  input
    .gsub(/(\w+)"s/, '\1\'s')  # Corrige les "method"s en method's
    .gsub(/"([^"]*?)"([^"]*?):/, '"\1\2":')  # Répare les guillemets mal formés dans les clés
end

  @path = ''
  @filer = grab(:intuition).box({ id: :filer,
                                  tag: { system: true },
                                  top: 9,
                                  depth: 0,
                                  left: 9,
                                  width: 120,
                                  height: 600,
                                  smooth: 8,
                                  overflow: :auto,
                                  apply: %i[inactive_tool_col tool_box_border tool_shade],
                                })

  def create_symlinks(base_path)
    offset = 0
    @path = base_path


    @filer.text({
                  data: 'parent',
                  color: :white,
                  cursor: :pointer,
                  left: 20,
                  top: 0 ,
                  position: :absolute,
                }).touch(:tap) do

      @filer.clear(true)
      @path = @path.chomp("/")  # Retire le "/" final s'il existe
      @path = @path[0, @path.rindex("/")] + "/"  # Remonte d'un niveau
      create_symlinks(@path)
    end

    # folder creation
    A.terminal("cd #{base_path}  && ls -d */ 2>/dev/null") do |data|
      data.each_line do |file|
        file = file.strip
        next if file.empty?

        parts = file.split("/")

        parts.each_with_index do |part, index|
          next if part.empty?
          @filer.text({
                        data: part,
                        color: :white,
                        cursor: :pointer,
                        left: index * 20,
                        top: 33 + offset,
                        position: :absolute,
                      }).touch(:tap) do

            @filer.clear(true)
            new_path = @path + "#{part}/"
            create_symlinks(new_path)
          end

          offset += 20
        end
      end
    end
    # files creation
    v = grab(:view)
    v.terminal("cd #{base_path}  && ls -p | grep -v /") do |data|
      data.each_line do |file|
        file = file.strip
        next if file.empty?

        parts = file.split("/")

        parts.each_with_index do |part, index|
          next if part.empty? # Ignorer les parties vides
          file_path = "#{base_path}/#{file}"
          @filer.text({
                        data: part,
                        color: :orange,
                        cursor: :pointer,
                        left: index * 20,
                        top: 33 + offset,
                        position: :absolute
                      }).touch(:tap) do
            ############### cest la
            grab(:view).clear(true)
            A.read(file_path) do |file_data|
              file_data=  repair_syntax(file_data)
              puts @a == file_data
              puts @a
              puts file_data


              eval(file_data)
              text data: "file content:\n#{file_data}", top: 9, left: 3
            end
          end

          offset += 20
        end
      end
    end
  end

  ################ test #######################
  # create_symlinks("../src/medias/utils/examples/")

  create_symlinks("../src/medias/utils/examples/")

  #######################################






