require_relative "input_devices"

class Keylogger
  DeviceNotFoundError = Class.new(StandardError)
  WrongPlatformError = Class.new(StandardError)

  def initialize(name = nil)
    unless InputDevices::SUPPORTED_PLATFORMS.include?(RUBY_PLATFORM)
      raise WrongPlatformError,
            "platform #{RUBY_PLATFORM} not supported"
    end

    @input_device = InputDevices.device

    raise DeviceNotFoundError unless device
  end

  def listen
    @input_device.listen(device) { |key| yield key }
  end

  private

  def device
    @input_device.find_by_name(name) ||
    @input_device.device.default
  end
end
