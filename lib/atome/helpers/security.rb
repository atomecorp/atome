# frozen_string_literal: true

# extensions for security
class Atome
  def authorise(input_password, destroy = true)
    password=Black_matter.encode(input_password)
    @temp_authorisation = [password, destroy]
  end

  def write_auth(element)
    if @security[element]
      password_found = @temp_authorisation[0]
      # puts @temp_authorisation[0]

      authorisation = Black_matter.check_password(password_found, Black_matter.password)
      password_destruction = @temp_authorisation[1]
      @temp_authorisation = [nil, true] if password_destruction
      return authorisation

    else
      true
    end
    true
  end

  def read_auth(element)
    if @security[element]
      password_found = @temp_authorisation[0]
      authorisation = Black_matter.check_password(password_found, Black_matter.password)
      password_destruction = @temp_authorisation[1]
      @temp_authorisation = [nil, true] if password_destruction
      return authorisation
    else
      true
    end
    true
  end

end