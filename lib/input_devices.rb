require_relative "input_devices/linux_x86"

class Keylogger
  module InputDevices
    SUPPORTED_PLATFORMS = {
      "x86_64-linux" => InputDevices::LinuxX86,
      "x86_64-linux-gnu" => InputDevices::LinuxX86
    }.freeze

    def self.device
      @device ||= SUPPORTED_PLATFORMS.fetch(RUBY_PLATFORM).new
    end
  end
end
