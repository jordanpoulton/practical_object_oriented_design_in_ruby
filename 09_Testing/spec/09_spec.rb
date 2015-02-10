require './lib/09'

describe Trip do
  let(:preparer){double 'Preparer'}
  let(:trip){Trip.new}

  it "responds to prepare" do
    expect(trip).to respond_to(:prepare)
  end

  it "is preparable" do
    expect(preparer).to receive(:prepare_trip).with(trip)
    trip.prepare([preparer])
  end
end

# Now you can go back to the tests in /09_Testing/04_spec.rb and remove the brittleness there:
=begin
class DiameterDouble
  def diameter
    10
  end
end

describe Gear do
  it 'also calculates gear inches' do
    gear = Gear.new(
      chainring: 52,
      cog: 11,
      wheel: DiameterDouble.new )
    expect(gear.gear_inches).to be_within(0.01).of 47.27
  end
end
=end

# We originally tried to counter this problem by raising the profile of the dependency in the tests in /09_testing/05_spec.rb:

=begin
describe Wheel do

  let(:wheel){Wheel.new(26,1.5)}

  # Here we explicitly say that it must respond to the diameter message to function properly.
  it "implements the diameterizable interface" do
    expect(wheel).to respond_to(:diameter)
  end

  it 'calculates diameter' do
    wheel = Wheel.new(26,1.5)
    expect(wheel.diameter).to be_within(0.01).of 29
  end
end
=end

# We now know how to fix this problem, don't we? Try writing the improved tests and working code that solves this brittleness. You should create a shared test that covers the 'Diameterizeable' role, then include it in the classes that play the Diameterizable role.














