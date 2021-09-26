require_relative "input_devices"

class Keylogger
  DeviceNotFoundError = Class.new(StandardError)
  WrongPlatformError = Class.new(StandardError)

  def initialize(name = nil)
    unless InputDevices::SUPPORTED_PLATFORMS.include?(RUBY_PLATFORM)
      raise WrongPlatformError,
            "platform #{RUBY_PLATFORM} not supported"
    end

    @device =
      InputDevices.device.find_by_name(name) ||
      InputDevices.device.default

    raise DeviceNotFoundError unless @device
  end

  def listen
    InputDevices.device.listen(@device)
  end
end
