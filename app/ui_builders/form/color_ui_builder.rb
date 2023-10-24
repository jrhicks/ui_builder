class Form::ColorUIBuilder
  attr_accessor :hue
  def initialize(hue)
    if hue.is_a?(Symbol)
      hue = hue.to_s
    end
    valid_hues = [
      'red',
      'orange',
      'amber',
      'yellow',
      'lime',
      'green',
      'emerald',
      'teal',
      'cyan',
      'light-blue',
      'blue',
      'indigo',
      'violet',
      'purple',
      'fuchsia',
      'pink',
      'rose',
      'warm-gray',
      'true-gray',
      'gray',
      'cool-gray',
      'blue-gray'
    ]
    if valid_hues.include?(hue)
      @hue = hue
    else
      raise "Invalid Hue: #{hue}"
    end
  end

  def dark
    if @hue == 'yellow'
      'bg-yellow-400'
    else
      "bg-#{hue}-700"
    end
  end

  def medium
    "bg-#{hue}-100"
  end

  def light
    "bg-#{hue}-50"
  end
end
