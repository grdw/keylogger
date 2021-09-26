require "spec_helper"

RSpec.describe Keylogger do
  describe "#initialize" do
    it "returns a keylogger instance" do
      device = Keylogger::InputDevices::LinuxX86::Device.new(name: "Test", event_id: "12", ev: "1")
      expect_any_instance_of(Keylogger::InputDevices::LinuxX86).to receive(:find_by_name).and_return(device)
      keylogger = Keylogger.new("Keychron Keychron K2")

      expect(keylogger).to be_a(Keylogger)
    end

    it "throws an error when windows" do
      stub_const("RUBY_PLATFORM", "i386-mingw32")

      expect { Keylogger.new("test") }.to raise_error(Keylogger::WrongPlatformError)
    end

    it "raises an error when device is not found" do
      device = nil
      expect_any_instance_of(Keylogger::InputDevices::LinuxX86).to receive(:find_by_name).and_return(device)
      expect_any_instance_of(Keylogger::InputDevices::LinuxX86).to receive(:default).and_return(device)
      expect { Keylogger.new("Wrong device") }.to raise_error(Keylogger::DeviceNotFoundError)
    end
  end
end
