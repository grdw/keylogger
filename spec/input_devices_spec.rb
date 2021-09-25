require "spec_helper"

RSpec.describe InputDevices do
  it "finds a device by a certain name" do
    expect(File).to receive(:read)
      .and_return(File.read("spec/mocked_devices"))

    device = InputDevices.find_by_name("Keychron Keychron K2")
  end
end
