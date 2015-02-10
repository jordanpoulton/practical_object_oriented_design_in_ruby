# Testing Duck Types

# Sometimes you want to write tests for roles that are shared across multiple object types. For this you can create shared tests that will prevent doubles from becoming obsolete.

# We're going to use the Preparer duck type from chap 05.

# We originally had a case statement (05_Duck_Types/02.rb) that meant that Trip had to check the class of each object to determine which message to send to it, which would have been a nightmare to test.

# As a result we created a 'Preparer' interface (prepare_trip(trip)) and had each role (Mechanic, Driver & TripCoordinator) implement this interface, as in the code in ./08.

# Now that we have this 'Preparable' role, we can write tests that check that any player of this role behaves correctly, and show that Trip interacts with them appropriately.

require './lib/08'

shared_examples "Preparer" do
  it "implements the Preparer interface" do
    expect(subject).to respond_to(:prepare_trip)
  end
end


describe TripCoordinator do

it_behaves_like "Preparer"

end

# Now that we created a shared_example module, you only need to write the test once, and *any* object that plays this will should be extended with the 'it_behaves_like' syntax.

describe Driver do

it_behaves_like "Preparer"

end

describe Mechanic do

it_behaves_like "Preparer"

end

# NB - the "implements the Preparable interface" method tests an incoming message, so belongs in the tests of the receiving object. The incoming messages go hand in hand with an outgoing message, and we must test both sides of the equation. We therefore need to implement a test that checks that Trip correctly sends the message to a Preparable to prepare a trip.
