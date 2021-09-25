require "spec_helper"

RSpec.describe Keylogger::InputDevices do
  it "finds a device by a certain name" do
    expect(File).to receive(:read)
      .and_return(File.read("spec/mocked_devices"))

    device = Keylogger::InputDevices.find_by_name("Keychron Keychron K2")
    expect(device.event_id).to eq("13")
  end
end
