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

def determine_action(file_content)
  default_action = { open: true, execute: false }
  action = default_action.dup

  if file_content.lines.first =~ /#\s*\{BROWSER:\s*\{(.*?)\}\}/
    content = $1.split(',').map { |pair| pair.split(':').map(&:strip) }.to_h
    content.each do |key, value|
      action[key.to_sym] = value == 'true'
    end
  end

  action
end

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
        file = file.strip
        next if file.empty?

        parts = file.split("/")

        parts.each_with_index do |part, index|
          next if part.empty?
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
            A.read(file_path) do |file_data|

              actions=    determine_action(file_data)
              if actions[:open] ==true

                editor=box({left: 150,
                            top: 9,
                            width: 399,
                            height: 699,
                            color: {red: 0.07, green: 0.07, blue: 0.07, alpha: 1.0},
                            overflow: :auto,
                            drag: true,
                            resize: true,
                           })

                # file title :
                editor.text({data: file, top: 0, left: 6, color: :orange})
                # file close
                close=editor.circle({color: :yellowgreen, left: :auto,right: 6, top: 9, width: 15, height: 15})
                close.text({data: :x, top: 0, left: 3, color: :black, position: :absolute})
                close.touch(:tap) do
                  editor.delete(true)
                end
                #file save
                save=editor.circle({color: :orange, left: :auto,right: 33, top: 9, width: 15, height: 15})
                save.touch(:tap) do
                  alert :save_file
                end
                # file body :
                body = editor.text({top: 39,left: 6, color: :lightgrey, data: file_data, edit: true})
              end

              # file exec if .rb :
              if file.end_with?('.rb')
                exec=editor.circle({color: :red, left: :auto,right: 66, top: 9, width: 15, height: 15})
                exec.touch(:tap) do
                  eval( body.data)
                end
              end

              if actions[:execute] ==true
                eval(file_data)
              end
            #
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






