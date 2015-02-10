# Remember the Bike inheritance hierarchy in chapter 6? How would you go about testing inherited code like this?

# The answer is to create shared_examples that test the Bike interface, which you expect all of the subclasses of bike (RoadBike, MountainBike) to respond to.

# You would then add these tests into the subclasses tests, using the it_behaves_like syntax.

# For subclass specializations, simply add those tests to the classes test suite, below the it_behaves_like code.
