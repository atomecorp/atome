class Atome
  ####### to meta-programming #######
  def left(value = nil, &particle_bloc)
    if value
      particle_setter(:left, { value: value, bloc: particle_bloc })
      # collapse

      collapse_particle(:left)
    else
      # we filter the bloc to return the value only
      value = getter(:left)[:value]
      particle = exec_optional_proc(:pre_get, { left: value })
      new_atome = atome({ atome: particle })
      new_atome.collapse
      new_atome
    end
  end

  def red(value = nil, &particle_bloc)
    if value
      particle_setter(:red, { value: value, bloc: particle_bloc })
    else
      # we filter the bloc to return the value only
      value = getter(:red)[:value]
      particle = exec_optional_proc(:pre_get, { red: value })
      new_atome = atome({ atome: particle })
      new_atome.collapse
      new_atome
    end
  end

  def color(particles = nil, &atome_bloc)
    if particles
      particles = sanitize_particles(particles, &atome_bloc)
      atome_setter(:color, particles)
    else
      particles = getter(:color)
      atome = exec_optional_proc(:pre_get, { color: particles })
      new_atome = atome(atome)
      new_atome.collapse
      new_atome
    end
  end

  def shadow(particles = nil, &atome_bloc)
    if particles
      particles = sanitize_particles(particles, &atome_bloc)
      atome_setter(:shadow, particles)
    else
      particles = getter(:shadow)
      atome = exec_optional_proc(:pre_get, { shadow: particles })
      new_atome = atome(atome)
      new_atome.collapse
      new_atome
    end
  end
end