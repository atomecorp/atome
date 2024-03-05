# frozen_string_literal: true

# extensions for security
class Atome
  def authorise(autorisations)
    autorisations[:read]&.each do |k, v|
      autorisations[:read][k] = Black_matter.encode(v)
    end
    autorisations[:write]&.each do |k, v|
      autorisations[:write][k] = Black_matter.encode(v)
    end

    @authorisations = autorisations
  end

  def check_password_destruction(operation, element)
    return unless @authorisations[:destroy]

    @authorisations[operation].delete(element)
  end

  def write_auth(element)
    if (@password && @password[:write]) && @authorisations && @authorisations[:write]
      if !@authorisations[:write][element]
        return false
      elsif @password[:write][element] == @authorisations[:write][element]
        # we check if we a specific password to read the particle
        check_password_destruction(:write, element)
        return true
      elsif @authorisations[:write][:atome] == @password[:write][:atome]

        puts "#{@authorisations[:write][:atome]} == #{@password[:write][:atome]}"
        check_password_destruction(:write, element)
        # we check if we a a password that allow to read the whole atome so all the particles
        return true
      else
        check_password_destruction(:write, element)
        return false
      end

      check_password_destruction(:write, element)
    else
      true
    end
  end

  def read_auth(element)

    if (@password && @password[:read]) && @authorisations && @authorisations[:read]
      if !@authorisations[:read][element]
        return false
      elsif @password[:read][element] == @authorisations[:read][element]
        check_password_destruction(:read, element)
        # we check if we a specific password to read the particle
        return true
      elsif @authorisations[:read][:atome] == @password[:read][:atome]
        check_password_destruction(:read, element)
        # we check if we a a password that allow to read the whole atome so all the particles
        return true
      else
        check_password_destruction(:read, element)

        return false
      end

      check_password_destruction(:read, element)
    else
      true
    end
  end
end
