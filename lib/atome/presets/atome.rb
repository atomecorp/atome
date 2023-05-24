# frozen_string_literal: true

# TODO: params shouldn't be merge but they must respect the order
# TODO: Add default value for each methods below
# TODO: Factorise codes below
# TODO we must clarified/unified the usage of presets and sanitizer it is not clear

class Atome
  def atome_common(atome_type, params)
    # TODO : optimise the whole code below and make it rubocop friendly
    essential_params = Essentials.default_params[atome_type] || {}
    essential_params[:type] = essential_params[:type] || :element
    essential_params[:renderers] = essential_params[:renderers] || @atome[:renderers]
    essential_params[:id] = params[:id] || identity_generator(atome_type)
    essential_params[:attach] = params[:attach] || [@atome[:id]] || [:view]
    essential_params.merge(params)
  end

  def box(params = {}, &bloc)
    atome_type = :box
    params = atome_common(atome_type, params)
    s=send(params[:type],params , &bloc)
    # Atome.new({ atome_type => params }, &bloc)
  end



  def circle(params = {}, &bloc)
    atome_type = :circle
    # puts "counter#{Universe.counter}"

    params = atome_common(atome_type, params)
    # puts "params ==> #{params} : #{Universe.counter}"
    send(params[:type],params , &bloc)
    # Atome.new({ atome_type => params }, &bloc)
  end


  def vector(params = {}, &bloc)
    atome_type = :vector
    params = atome_common(atome_type, params)
    # params={"type"=>"shape", "width"=>99, "height"=>99, "attach"=>["view"], "left"=>100, "top"=>100, "clones"=>[], "preset"=>"vector", "definition"=>"<g transform=\"matrix(0.0267056,0,0,0.0267056,18.6376,20.2376)\">\n    <g id=\"shapePath1\" transform=\"matrix(4.16667,0,0,4.16667,-377.307,105.632)\">\n        <path d=\"M629.175,81.832C740.508,190.188 742.921,368.28 634.565,479.613C526.209,590.945 348.116,593.358 236.784,485.002C125.451,376.646 123.038,198.554 231.394,87.221C339.75,-24.111 517.843,-26.524 629.175,81.832Z\" style=\"fill:rgb(201,12,125);\"/>\n    </g>\n    <g id=\"shapePath2\" transform=\"matrix(4.16667,0,0,4.16667,-377.307,105.632)\">\n        <path d=\"M1679.33,410.731C1503.98,413.882 1402.52,565.418 1402.72,691.803C1402.91,818.107 1486.13,846.234 1498.35,1056.78C1501.76,1313.32 1173.12,1490.47 987.025,1492.89C257.861,1502.39 73.275,904.061 71.639,735.381C70.841,653.675 1.164,647.648 2.788,737.449C12.787,1291.4 456.109,1712.79 989.247,1706.24C1570.67,1699.09 1982.31,1234 1965.76,683.236C1961.3,534.95 1835.31,407.931 1679.33,410.731Z\" style=\"fill:rgb(201,12,125);\"/>\n    </g>\n</g>\n", "renderers"=>["browser"], "id"=>"user_view_vector_16"}

    # Atome.new({ atome_type => params }, &bloc)
    send(params[:type],params, &bloc )


  end

end



