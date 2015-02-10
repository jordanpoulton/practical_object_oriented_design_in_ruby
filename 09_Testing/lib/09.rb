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
