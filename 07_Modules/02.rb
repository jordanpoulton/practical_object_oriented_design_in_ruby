# The strategy - take an arbitrary concrete class, like Bikes, and implement the schedulable? method directly in that class. Once you have a version that works, you can refactor your way to a code arrangement that allows all Schedulables to share this behaviour.

class Schedule
  def scheduled?(schedulable, starting, ending)
    puts "This #{schedulable.class} is not scheduled between #{starting} and #{ending}"
    false
  end
end

class Bike
  attr_reader :schedule, :size, :chain, :tyre_size

# Inject Schedule and provide a default
  def initialize(args={})
    @schedule = args[:schedule] || Schedule.new
  end

# Return true if Bike available, durig this BIKE SPECIFIC window
  def schedulable?(starting, ending)
    !scheduled?(starting - lead_time, ending)
  end

# Return the schedules answer
  def scheduled?(starting, ending)
    schedule.scheduled?(self, starting, ending)
  end

# Object specific number of lead days required
  def lead_time
    1
  end
end

require 'date'

starting = Date.parse("2015/09/04")
ending = Date.parse("2015/09/10")

b = Bike.new
p b.schedulable?(starting, ending)

# Now we have a feel for what the schedulable? method should do, it's time to rearrange the code so that it can be shared among objects of different classes
