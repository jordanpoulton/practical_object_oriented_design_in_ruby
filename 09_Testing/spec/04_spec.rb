# Coupling our tests with multiple classes is going to cause us a lot of headaches further down the road. What we want to do is encapsulate our tests themselves as much as possible, which we can do with Test Doubles.

# Test Doubles are fake objects that play the ROLE that we expect a real object to play in our application.

# To continue to use Gear and Wheel, the Gear expects the wheel to ACT as a DIAMETERIZABLE object. We can do this (badly - this is not best practise) like so, if we really want to:
require '04'

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

# This gives you an idea of what a double is there to do... This IS NOT how you would create and use one in practise, but you can see how it works at least, and now there is no link to the Wheel class - we're testing that wheel is initialized with an object that implements the 'DIAMETERIZABLE' interface - meaning... It responds to the method 'diameter'.

# To use the technical term, we've *stubbed* diameter here. We've implemented a version of diameter that returns a canned answer. In RSpec, you would write this slightly differently:

describe Gear do

  # Now we create a 'diameter_double' RSpec variable, using the 'let syntax', passing it a block which instructs it be set to a double, called 'diameter_double', with a single stubbed method, 'diameter', that always returns 10 when called:

  let(:diameter_double) { double 'diameter_double', diameter: 10}

  it 'also calculates gear inches' do
    gear = Gear.new(
      chainring: 52,
      cog: 11,
      wheel: diameter_double )
    expect(gear.gear_inches).to be_within(0.01).of 47.27
  end
end
