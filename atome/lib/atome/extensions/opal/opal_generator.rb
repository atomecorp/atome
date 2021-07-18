module JSUtils
  # 0 : Alex,is en-US
  # 1 : Alice,is it-IT
  # 2 : Alva,is sv-SE
  # 3 : Amelie,is fr-CA
  # 4 : Anna,is de-DE
  # 5 : Carmit,is he-IL
  # 6 : Damayanti,is id-ID
  # 7 : Daniel,is en-GB
  # 8 : Diego,is es-AR
  # 9 : Ellen,is nl-BE
  # 10 : Fiona,is en-scotland
  # 11 : Fred,is en-US
  # 12 : Ioana,is ro-RO
  # 13 : Joana,is pt-PT
  # 14 : Jorge,is es-ES
  # 15 : Juan,is es-MX
  # 16 : Kanya,is th-TH
  # 17 : Karen,is en-AU
  # 18 : Kyoko,is ja-JP
  # 19 : Laura,is sk-SK
  # 20 : Lekha,is hi-IN
  # 21 : Luca,is it-IT
  # 22 : Luciana,is pt-BR
  # 23 : Maged,is ar-SA
  # 24 : Mariska,is hu-HU
  # 25 : Mei-Jia,is zh-TW
  # 26 : Melina,is el-GR
  # 27 : Milena,is ru-RU
  # 28 : Moira,is en-IE
  # 29 : Monica,is es-ES
  # 30 : Nora,is nb-NO
  # 31 : Paulina,is es-MX
  # 32 : Rishi,is en-IN
  # 33 : Samantha,is en-US (genevrator_helper.js, line 15)
  # 34 : Sara,is da-DK
  # 35 : Satu,is fi-FI
  # 36 : Sin-ji,is zh-HK
  # 37 : Tessa,is en-ZA
  # 38 : Thomas,is fr-FR
  # 39 : Ting-Ting,is zh-CN
  # 40 : Veena,is en-IN
  # 41 : Victoria,is en-US
  # 42 : Xander,is nl-NL
  # 43 : Yelda,is tr-TR
  # 44 : Yuna,is ko-KR
  # 45 : Yuri,is ru-RU
  # 46 : Zosia,is pl-PL
  # 47 : Zuzana,is cs-CZ
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
    sentence = params[:content]
    voice_number = language_code(params[:voice])
    `say(#{sentence}, #{voice_number})`
  end

end