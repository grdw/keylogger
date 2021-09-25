require "spec_helper"

RSpec.describe Keylogger::InputDevices do
  before do
    expect(File).to receive(:read)
      .and_return(File.read("spec/mocked_devices"))
  end

  it "finds a device by a certain name" do
    device = Keylogger::InputDevices.find_by_name("Keychron Keychron K2")
    expect(device.event_id).to eq("13")
  end

  it "finds the first keyboard in the list" do
    device = Keylogger::InputDevices.default
    expect(device.event_id).to eq("13")
  end
end
