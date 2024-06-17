# frozen_string_literal: true

new ({ particle: :password, category: :security, type: :string })
new ({ sanitizer: :password }) do |params|

  params = { read: params, write: params } unless params.instance_of? Hash

  # encoding below
  params[:global] = Black_matter.encode(params[:global])

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
  # TODO : check if we have to reactive the lines below

  params
end
