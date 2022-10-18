`startMediaStreaming();`

mute_unmute_mic = box

mic_text = mute_unmute_mic.text("mic on")
mute_unmute_mic.color("yellow")
mute_unmute_mic.text("mic on")
mute_unmute_mic.z = 5
mute_unmute_mic.disposition(x: 5)

mute_unmute_mic.touch do
  if mute_unmute_mic.color == "red"
    mute_unmute_mic.color = 'yellow'
    mic_text.content("mic on")
    `mediaStreamingHelper.unmuteMicrophone();`
  else
    mute_unmute_mic.color("red")
    mic_text.content("mic off")
    `mediaStreamingHelper.muteMicrophone();`
  end
end

pause_resume_webcam = box

webcam_text = pause_resume_webcam.text("webcam on")
pause_resume_webcam.color("yellow")
pause_resume_webcam.text("webcam on")
pause_resume_webcam.z = 5
pause_resume_webcam.disposition(x: 5)

pause_resume_webcam.touch do
  if pause_resume_webcam.color == "red"
    pause_resume_webcam.color = 'yellow'
    webcam_text.content("webcam on")
    `mediaStreamingHelper.resumeWebcam();`
  else
    pause_resume_webcam.color("red")
    webcam_text.content("webcam off")
    `mediaStreamingHelper.pauseWebcam();`
  end
end