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

  ################ code to develop #######################

# def repair_syntax(input)
#   # input
#   #   .gsub(/(\w+)"s/, '\1\'s')  # Corrige les "method"s en method's
#   #   .gsub(/"([^"]*?)"([^"]*?):/, '"\1\2":')  # Répare les guillemets mal formés dans les clés
#   input
# end

  @path = ''
  @filer = grab(:intuition).box({ id: :filer,
                                  tag: { system: true },
                                  drag: true,
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
            new_path = @path + "/#{part}"
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
        # puts "-----"
        # puts file
        # puts "--- ok ---"
        file = file.strip
        next if file.empty?

        parts = file.split("/")

        parts.each_with_index do |part, index|
          next if part.empty? # Ignorer les parties vides
          file_path = "#{base_path}/#{file}"
          #FIXME check in the code whywe need to do that
          file_path=file_path.gsub("//", "/")
          @filer.text({
                        data: part,
                        color: :orange,
                        cursor: :pointer,
                        left: index * 20,
                        top: 33 + offset,
                        position: :absolute
                      }).touch(:tap) do
            # ############### cest la
            grab(:view).clear(true)
            # alert file_path
            A.read(file_path) do |file_data|
            #   puts "0000"
            #   puts "1 : #{file_data}"
            #   # file_data=  repair_syntax(file_data)
            #   # puts @a == file_data
            #   # puts @a
            #   puts file_data
            #   # file_data=file_data.gsub('#{','\#{')


            eval(file_data)
            #   text data: "file content:\n#{file_data}", top: 9, left: 3
            end
          end

          offset += 20
        end
      end
    end
  end

  ################ test #######################
  create_symlinks("../src/medias/utils/examples")
  #######################################






