# #  frozen_string_literal: true

# puts "current user: #{Universe.current_user}"
# human({ id: :jeezs, login: true })
#
# puts "current user: #{Universe.current_user}"
# wait 2 do
#   human({ id: :toto, login: true })
#   puts "current user: #{Universe.current_user}"
# end

puts 'ok1'

  # Vérification que les champs email et password ne sont pas envoyés vides :
  # if (email_text.data.nil? || email_text.data.strip.empty?) && (password_text.data.nil? || password_text.data.strip.empty?)
  #   puts "Veuillez renseigner votre adresse email et votre mot de passe."
  # elsif email_text.data.nil? || email_text.data.strip.empty?
  #   puts "Veuillez renseigner votre adresse email."
  # elsif password_text.data.nil? || password_text.data.strip.empty?
  #   puts "Veuillez renseigner votre mot de passe."
  # else

    mail = 'tretre'
    pass = 'poipoi'
    pass = Black_matter.encode(pass)


    # A.message({ action: :authentication, data: { table: :user, particles: {email: mail, password: pass} } }) do |response|
    #   puts "authentication : #{response}"
    # end

    mail_message = false
    mail_response = nil
    password_message = false
    password_response = nil
wait 3 do
  A.message({ action: :authentication, data: { table: :user, particles: {email: mail} } }) do |response|
    puts "Full authentication response: #{response.inspect}"
    if response.key?('mail_authorized')
      # Logique si 'authorized' est présent dans la réponse
      puts "response mail authorized: #{response['mail_authorized']}"
      # Si le mail et le password sont ok, on log le user et on stocke l'info en local storage
      mail_message = JS.global[:localStorage].setItem('logged', response['mail_authorized'])
      mail_response = response['mail_authorized']
      puts "mail_response : #{mail_response}"
      # On efface le formulaire si le serveur renvoie que l'user est loggé
      # view.delete(true)
      JS.global[:localStorage].setItem('user_id', response['user_id'])
    else
      # Gestion du cas où 'authorized' est absent
    end

  end

  A.message({ action: :authorization, data: { table: :user, particles: {password: pass} } }) do |response|
    puts "authorization : #{response}"
    if response.key?('password_authorized')
      authorized = response['password_authorized'] || false  # Utilisez false comme valeur par défaut si 'authorized' est absent
      puts "response password : #{response['password_authorized']}"
      # Si le mail et le password sont ok, on log le user et on stocke l'info en local storage
      password_message = JS.global[:localStorage].setItem('logged', response['password_authorized'])
      password_response = response['password_authorized']
      puts "password_response : #{password_response}"
      # On efface le formulaire si le serveur renvoie que l'user est loggé
      # view.delete(true)
      JS.global[:localStorage].setItem('user_id', response['user_id'])
    else
      # Gestion du cas où 'authorized' est absent
    end
  end
end


    # # # On efface le formulaire si le serveur renvoie que l'user est loggé
    # if (mail_response == "true" || password_response == "true")
    #   view.delete(true)
    #   puts 'deleted!'
    #   # JS.global[:localStorage].setItem('user_id',response['user_id'])
    #   # puts "response user_id : #{response['user_id']}"
    # end

  # end

puts 'ok2'