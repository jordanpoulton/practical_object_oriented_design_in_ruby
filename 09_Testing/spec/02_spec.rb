require '02'

# The following code tests Wheel's #diameter method. It's super simple and not very exciting

describe Wheel do
  it 'calculates diameter' do
    wheel = Wheel.new(26,1.5)
    expect(wheel.diameter).to be_within(0.01).of 29
  end
end

# Gear is a little more interesting, as it requires a more comple setup

describe Gear do
  xit 'calculates gear inches' do
    gear = Gear.new(
      chainring: 52,
      cog: 11,
      rim: 26,
      tire: 1.5 )
    expect(gear.gear_inches).to be_within(0.01).of 137.1
  end
end

# The fact that we can't test Gear in isolation bodes badly for the future. This is where dependency injection comes into its own.
