class Keylogger
  SUPPORTED_PLATFORMS = %w[x86_64-linux x86_64-linux-gnu].freeze
  FORMAT = "l!<l!<HHI!<".freeze
  MIN_ID = 0
  MAX_ID = 59

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
    loop do
      line = file.read(24)
      value = line.unpack(FORMAT).last

      yield value if value > MIN_ID && value < MAX_ID
    end
  end

  private

  def device
    @device ||= InputDevices.find_by_name(@name)
  end
end
