require '10'

shared_examples "Diameterizable" do
  it "implements the Diameterizable interface" do
    expect(subject).to respond_to(:diameter)
  end
end

describe Wheel do

  it_behaves_like "Diameterizable" do
    let(:diameterizable){Wheel.new(26, 1.5)} #If you don't provide the initialisation sequence to the shared_example, it will try to instantiate the subject with 0 rather than 2 arguments. The block will pass an object to be used as 'subject' by the shared_example
  end

  it "calculates Diameter" do
    #...
  end
end

# And it should be easy for you to implement this in Gear now, right?

# The secret is to test your doubles as you would any other role player - test them to prove their correctness, and you can stub without fear.
