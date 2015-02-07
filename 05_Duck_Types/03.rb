# The key to finding the duck is working out what the single PURPOSE is for each, seemingly unrelated class. Ask yourself what 'prepare' needs.

# It's really quite simple - the prepare method wants to prepare the trip. It's arguments arrive in preparation for trip preparation.

# It simply expects that whatever object is passed to it, that object is a 'Preparer'

# So what message do we want to send each Preparer? The answer is simple...

# prepare_trip

# Be very clear - 'Preparer' is an abstraction. It's an agreement about an object's interface. It is a contract that any object passed in understands ITS OWN responsibilities when preparing a trip.

# So - Mechanics, TripCoordinators and Drivers should behave like Preparers - they should implement 'prepare_trip'.

class Trip
  attr_reader :bikes, :customers, :vehicle

  def prepare(preparers)
    preparers.each do |preparer|
      preparer.prepare_trip(self)
    end
  end
  #...
end

class TripCoordinator

  def prepare_trip(trip)
    buy_food(trip.customers)
  end

  def buy_food(customers)
    #..
  end
end

class Driver
  def prepare_trip(trip)
  vehicle = trip.vehicle
  gas_up(vehicle)
  fill_water_tank(vehicle)
  end

  def gas_up(vehicle)
    #..
  end

  def fill_water_tank(vehicle)
    #..
  end
end

class Mechanic
  def prepare_trip(trip)
    trip.bikes.each {|bike| prepare_bike(bike)}
  end

  def prepare_bike(bike)
    #...
  end
end

# Now, if more we want to add more roles in the preparation of a trip, we simply have to add the Preparer role (ie, responding to the 'prepare_trip' method) to them, and they will work.

# This is what many people refer to as Polymorphism. It refers to teh ability of many different objects to respond to the same message. Senders of the message need not care about the class of the receiver; receivers supply their own specific version of the behaviour.
# A single message, therefore, has many(poly) forms(morphs).

# As a rule of thumb, whenever you see:

# Case statements
# kind_of? and is_a? (unless referring to core classes like String, Array, Hash)
# responds_to?

# Then you might want to take some time to think if you've got yourself a hidden duck.

# We will get on to how you write good tests for ducks later.
