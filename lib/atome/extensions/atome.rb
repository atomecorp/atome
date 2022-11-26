# frozen_string_literal: true

def grab(atome_to_get)
  Universe.atomes[atome_to_get]
end

def box(params = {}, &proc)
  grab(:view).box(params, &proc)
end

def circle(params = {}, &proc)
  grab(:view).circle(params, &proc)
end

def text(params = {}, &bloc)
  grab(:view).text(params, &bloc)
end

def image(params = {}, &bloc)
  grab(:view).image(params, &bloc)
end

def video(params = {}, &bloc)
  grab(:view).video(params, &bloc)
end

def color(params = {}, &bloc)
  grab(:view).color(params, &bloc)
end

def element(params = {}, &bloc)
  grab(:view).element(params, &bloc)
end

def shadow(params = {}, &bloc)
  grab(:view).shadow(params, &bloc)
end

# def code(params = {}, &bloc)
#   grab(:view).code(params, bloc)
# end
