module JSUtils
  # speech recognition
  def js_speech_recognition(local_lang, &proc)
    language_found= case local_lang
                    when :english
                      "en-US"
                    when :french
                      "fr-FR"
                    else
                      "en-US"
                    end
    `speechAnalysis=new UserRecognition(#{language_found},#{proc})`
  end

  def self.speech_recognition_callback(datas, proc)
    proc.call(datas) if proc.is_a?(Proc)
  end
end
