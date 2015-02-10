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
