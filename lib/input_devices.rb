class Keylogger
  module InputDevices
    KEYBOARD_EV = "120013".freeze
    DEVICE_REGEX = /
      N:\sName="(?<name>.+)"(\n|.)*
      H:\sHandlers=.*event(?<event_id>[0-9]+).*(\n|.)*
      B:\sEV=(?<ev>[0-9]+)
    /x.freeze

    Device = Struct.new(:name, :event_id, :ev, keyword_init: true)

    def self.find_by_name(name)
      devices.detect do |device|
        device.name == name && device.ev == KEYBOARD_EV
      end
    end

    def self.devices
      @devices ||= begin
        contents = File.read("/proc/bus/input/devices")
        contents.split("\n\n").map do |device|
          blob = DEVICE_REGEX.match(device).named_captures
          Device.new(blob)
        end
      end
    end
  end
end
