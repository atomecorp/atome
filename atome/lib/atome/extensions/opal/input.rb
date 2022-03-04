module JSUtils
  # speech recognition
  def speech_recognition(local_lang, status, &proc)
    language_found = case local_lang
                     when :english
                       "en-US"
                     when :french
                       "fr-FR"
                     else
                       "en-US"
                     end
    `const speechAnalysis=new SpeechRecognitionHelper(#{language_found},#{proc})`
    if status.to_sym == :start
      `speechAnalysis.start_recognition()`
    else
      `speechAnalysis.stop_recognition()`
    end

  end

  def self.speech_recognition_callback(datas, proc)
    proc.call(datas) if proc.is_a?(Proc)
  end

  def self.pay(payment_id, link)
    `new PaymentHelper(#{payment_id},#{link})`
  end
end
