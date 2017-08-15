require "spec_helper"

RSpec.describe Artsy::Rack::Auth::Admin::Only do
  it "has a version number" do
    expect(Artsy::Rack::Auth::Admin::Only::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
