module JSUtils
  # speech recognition
  def js_speech_recognition(&proc)
    `speechAnalysis=new UserRecognition(#{proc})`
  end

  def self.speech_recognition_callback(datas, proc)
    proc.call(datas) if proc.is_a?(Proc)
  end
end
