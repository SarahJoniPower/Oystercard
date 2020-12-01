require "station"

describe Station do
  let(:station) {Station.new("Euston", 1)}
  it { expect(station).to be_instance_of(Station) }

  it { expect(station.name).to eq("Euston") }

  it { expect(station.zone).to eq(1) }

end
