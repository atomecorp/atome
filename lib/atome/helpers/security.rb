# frozen_string_literal: true

# extensions for security
class Atome
  def authorise(password, destroy = true)
    @temp_authorisation = [password, destroy]
  end

  def write_auth(element)
    if @security[element]
      password_found = @temp_authorisation[0]

      authorisation = Black_matter.check_password(password_found, Black_matter.password)
      password_destruction = @temp_authorisation[1]
      @temp_authorisation = [nil, true] if password_destruction
      puts authorisation
      # return true if authorisation == true
      return authorisation

    else
      true
    end
    true
  end

  def read_auth(element)
    # if @password
    #   puts "=> for id #{@id}, particle : #{element}, password is : #{@password} "
    # end
    if @security[element]
      password_found = @temp_authorisation[0]
      authorisation = Black_matter.check_password(password_found, Black_matter.password)
      password_destruction = @temp_authorisation[1]
      @temp_authorisation = [nil, true] if password_destruction
      true if authorisation
    else
      true
    end
    true
  end

end