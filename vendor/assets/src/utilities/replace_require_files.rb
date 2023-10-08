def resolve_requires(file_path, root_path, processed_files = Set.new, depth = 0)
  return "" unless File.exist?(file_path)
  return "" if processed_files.include?(file_path) || depth > 10 # Vérifiez les dépendances circulaires et la profondeur

  content = File.read(file_path)
  processed_files.add(file_path)

  current_dir = File.dirname(File.expand_path(file_path)) # Utilisez le chemin absolu

  content.gsub!(/^(require|require_relative)\s+['"](.*?)['"]$/) do |match|
    type = $1
    required_file_name = $2
    required_file = if type == "require_relative"
                      File.join(current_dir, required_file_name + ".rb")
                    else
                      File.join(root_path, required_file_name + ".rb")
                    end

    if File.exist?(required_file)
      resolve_requires(required_file, root_path, processed_files, depth + 1)
    else
      match
    end
  end

  content
end

def generate_resolved_file(source_file_path, output_file_path)
  root_path = File.dirname(File.expand_path(source_file_path))
  resolved_content = resolve_requires(source_file_path, root_path)
  # File.write(output_file_path, resolved_content)
  resolved_content
end

# Utilisation:
source_file_path = "../../application/index.rb"
output_file_path = "../../../../tmp/test_app/temp/result.rb"
generate_resolved_file(source_file_path, output_file_path)
