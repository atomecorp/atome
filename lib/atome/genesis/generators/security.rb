# frozen_string_literal: true

new ({ particle: :password })
new ({ sanitizer: :password }) do |params|

  params = { read: params, write: params } unless params.instance_of? Hash

  # encoding below
  params[:read]&.each do |k, v|
    params[:read][k] = Black_matter.encode(v)
  end
  params[:write]&.each do |k, v|
    params[:write][k] = Black_matter.encode(v)
  end

  params[:read] = Black_matter.password unless params[:read]
  params[:write] = Black_matter.password unless params[:write]

  if type == :human
    # we store the hashed password into the Universe for easier access
    Black_matter.set_password(params)
  end
  params
end

new({ read: :password }) do |params|
  params = Black_matter.password if params.nil?
  params[:read][:atome]=Black_matter.password[:read][:atome] unless @authorisations[:write][:atome]
  params[:write][:atome]=Black_matter.password[:write][:atome] unless @authorisations[:write][:atome]
  params
end
