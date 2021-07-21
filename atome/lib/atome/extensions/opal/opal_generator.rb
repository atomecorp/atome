module JSUtils
  def language_code(language_code)
    case language_code
    when :french
      38
    when :italian
      1
    when :english
      33
    when :russian
      27
    when :portuguese
      13
    when :nederland
      43
    when :spanish
      14
    when :germany
      4
    when :japanese
      18
    when :chinese
      39
    else
      0
    end
  end

  def speech_dsp(params)

    if params.instance_of?(String) || params.instance_of?(Symbol) || params.instance_of?(Integer)
      params = { content: params }
    end
    unless params[:voice]
      params[:voice] = get_language
    end
    sentence = params[:content]
    voice_number = language_code(params[:voice])
    `say(#{sentence}, #{voice_number})`
  end

end