#module Processors
#  def transmit(value)
#    case value[:protocole]
#    when :midi
#      self.midi_communication(value[:content])
#    when :beaglebone
#      # bbb communication layer
#    else
#      value
#    end
#  end
#end

module Processors
  def transmit(values)
    case values.keys[0]
    when :midi
      default = {note: 39, channel: 1}
      #alert values[:midi]
      case values[:midi].keys[0]
      when :play
        note = values[:midi][:play].delete(:note)
        channel = values[:midi][:play].delete(:channel)
        options = values[:midi][:play]
        midi_play(note, channel, options)
      when :stop
        note = values[:midi][:stop].delete(:note)
        channel = values[:midi][:stop].delete(:channel)
        options = values[:midi][:stop]
        midi_stop(note, channel, options)

      when :inputs
        #alert :kool

      when :outputs

      else
      end

    when :beaglebone
      # bbb communication layer
    else
      value
    end
  end
end