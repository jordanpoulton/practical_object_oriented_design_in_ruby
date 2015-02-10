# The problem we now have with the doubles being used in 04, is that eventually the code will change, and there is a risk that our tests pass even though our code doesn't work.

# If the 'diameter' method in Wheel changed to 'width', our Gear tests would still pass because we are testing that it using a double that still implements 'diameter'.

# So what can we do to avoid this?

# One strategy is to raise the visibility of the 'Diameterizable' role by adding it to the Wheel tests

require '05'

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

# This is fine at the start, but what about if we want LOTS of objects to be able to respond to the Diameterizable role? We're going to have to duplicate a lot of code...

# Roles, as we will show, need tests OF THEIR OWN.
