# frozen_string_literal: true
# alert grab(:view).aid
# alert grab(:view).id


aid_found=grab(:view).aid
puts "aid must be :view #{aid_found}"


new({template: :my_template}) do
  # aid must be consistent

end

new({code: :my_code}) do

end

new({tool: :my_tool}) do

end


new({test: :my_test}) do

end




