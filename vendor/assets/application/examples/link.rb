# frozen_string_literal: true

# File link demo

def create_file_link(file_path, display_text)
  link = text({
                data: display_text,
                color: :orange,
                cursor: :pointer
              })
  link.touch(:tap) do
    A.read(file_path) do |data|
      text "file content  :\n #{data}"
    end
  end

  link
end

create_file_link('../application/examples/blur.rb', 'Cliquez ici pour ouvrir le fichier')
