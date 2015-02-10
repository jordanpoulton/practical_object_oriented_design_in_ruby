# Mocks are tests of BEHAVIOUR, as opposed to tests of STATE. Instead of making expectations about what a message returns, mocks define an expectation that a message will be sent.

# The following test verifies that Gear fulfills its responsbilities, WITHOUT binding it to Observer's behaviour. We will create a mock, that we will inject in the place of the Observer, and each test tells the mock to EXPECT to RECEIVE the CHANGED message, then executes the relevant code, and subsequently verifies that the expectation was met.
require '07'

describe Gear do
  let(:observer){double 'observer'}

  before(:each) do
    @gear = Gear.new({
      chainring: 52,
      cog: 11,
      observer: observer
    })
  end

  it "notifies observer when cogs change" do
    expect(observer).to receive(:changed).with(52, 27)
    @gear.set_cog(27)
  end

  it "notifies observer when chainrings change" do
    expect(observer).to receive(:changed).with(42, 11)
    @gear.set_chainring(42)
  end
end

# Line 18 tells the mock what to expect - to receive the 'changed' method with 2 arguments
# Line 19 then triggers the expected behaviour and it will pass if the expectation if met, fail if it is not.

# Same for lines 23 and 24.

# The test only passes if sending set_chainring to Gear does something that causes observer to reveive 'changed' with the given arguments.

# FYI the Mock can be configured to return a specific value, but the return value should really be incidental. Mocks are meant to prove that messages get sent - they return results ONLY when necessary to get the tests to run correctly.
