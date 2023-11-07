# frozen_string_literal: true

new ({ particle: :security })

new ({ sanitizer: :security }) do |params|
  params.each do |_particle, protection|
    if protection[:write]
      write_password = protection[:write][:password]
      protection[:write][:password] = Black_matter.encode(write_password) if write_password
    end

    if protection[:read]
      read_password = protection[:read][:password]
      protection[:read][:password] = Black_matter.encode(read_password) if read_password
    end

  end
  params
end

new ({ particle: :password })
new ({ sanitizer: :password }) do |params|
  params = Black_matter.encode(params)
  if type == :human
    # we store the hashed password into the Universe for easier access
    Black_matter.set_password(params)
  end
  params
end
