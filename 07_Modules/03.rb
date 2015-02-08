module Schedulable
  attr_reader :schedule

# Inject Schedule and provide a default
  def schedule
    @schedule || Schedule.new
  end

# Return true if object that includes this module is available, durig this BIKE SPECIFIC window
  def schedulable?(starting, ending)
    !scheduled?(starting - lead_time, ending)
  end

# Return the schedules answer
  def scheduled?(starting, ending)
    schedule.scheduled?(self, starting, ending)
  end

# Includers will override this with their specific lead times, using the TEMPLATE PATTERN
  def lead_time
    0
  end
end

# The difference from the code as we used in bike is: a schedule method, that returns the schedul eobject or creates a new one. By doing this, the instigating object doesn't need to pass in a schedule, and therefore needs no knowledge of Schedule, thus decoupling it. The dependency on Schedule has been moved now into the Schedulable module, isolating it even further.

# We've also added the lead_time method, with a generic default that we expect to be overriden by includers, similar to how you would frame the problem using the classical inheritance technique.

# We can now include this module in any class to give them the code they need to play the Schedulable role...

class Vehicle
  include Schedulable

  def lead_time
    3
  end
end

class Bike
  include Schedulable

# Object specific number of lead days required
  def lead_time
    1
  end
end

class Mechanic
  include Schedulable

# Object specific number of lead days required
  def lead_time
    4
  end
end

# Obviously we need the Schedule code for all this to work:

class Schedule
  #..
  def scheduled?(schedulable, starting, ending)
    puts "This #{schedulable.class} is not scheduled between #{starting} and #{ending}"
    false
  end
  #..
end

# And now we can show it in action

require 'date'

starting = Date.parse("2015/09/04")
ending = Date.parse("2015/09/10")

b = Bike.new
p b.schedulable?(starting, ending)

v = Vehicle.new
p v.schedulable?(starting, ending)

m = Mechanic.new
p m.schedulable?(starting, ending)
