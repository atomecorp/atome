module PropertyHtml

  def listen_html(params, &proc)
    if params.instance_of?(Hash)
      language = params[:language]
      status = params[:status]
    else
      if params == :start
        status = :start
        language = ""
      elsif params == :stop
        status = :stop
        language = ""
      else
        language = params
        status = :start
      end
    end
    speech_recognition(language, status, &proc)
  end

  # def camera_html(value="")
  #   value
  # end
  #
  # def microphone_html(value="")
  #   value
  # end
  #
  # def midi_html(value="")
  #   value
  # end
end
