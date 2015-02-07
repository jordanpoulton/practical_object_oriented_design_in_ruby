# In the following code, Trip's 'prepare' method sends the message 'prepare_bikes' to the object contained in its mechanic parameter.

# Notice that the Mechanic class is not referenced - even though the name of the parameter is 'mechanic', the object containted within it could technically be any class - so long as it responds to 'prepare_bikes'

class Trip
  attr_reader :bikes, :customers, :vehicle

  def prepare(mechanic)
    mechanic.prepare_bikes
  end
  #...
end

class Mechanic
  def prepare_bikes(bikes)
    bikes.each {|bike| prepare_bike(bike)}
  end

  def prepare_bike(bike)
    #...
  end
end

# Under this model, an outside object would need to kick the whole thing off by sending 'prepare' to Trip, passing an argument along with it.
# The prepare method doesn't necessarily need to be passed a Mechanic, but it does need to be passed an object that responds to 'prepare_bikes'

# Now imagine that there is a change in requirements, and the preparation of a Trip will involve a TripCoordinator and a Driver as well as a Mechanic.

# You might write this sort of code:

class Trip
  attr_reader :bikes, :customers, :vehicle

  def prepare(preparers)
    preparers.each do |preparer|
      case preparer
      when Mechanic
        preparer.prepare_bikes(bikes)
      when TripCoordinator
        preparer.buy_food(customers)
      when Driver
        preparer.gas_up(vehicle)
        preparer.fill_water_tank(vehicle)
      end
    end
  end
  #...
end

class TripCoordinator
  def buy_food(customers)
    #..
  end
end

class Driver
  def gas_up(vehicle)
    #..
  end

  def fill_water_tank(vehicle)
    #..
  end
end

# Does the CASE method make you feel icky?!?! It should.
# The 'prepare' method is now tightly bound to 3 different classes, as well as the arguments which those classes require to act. What other issues might this code lead to further down the line?
