require '03.rb' # This gets us access to the Wheel class's code, which is messy...

# With the Wheel being a dependency injection now, the dependency will have to be reflected in our tests:
describe Gear do
  it 'calculates gear inches' do
    gear = Gear.new(
      chainring: 52,
      cog: 11,
      wheel: Wheel.new(26,1.5) )
    expect(gear.gear_inches).to be_within(0.01).of 137.1
  end
end

# Unless we include the class in the test, it will not work. This makes the dependency very publicly visible, and it means that your tests will always break when they should.
