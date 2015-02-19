# Inheritance isn't the only technique for sharing behaviour in Ruby.

# In fact, every instance where Inheritance is possible can also be solved using another technique - modules.

# Some problems require sharing behaviour among otherwise unrelated objects. Its a role that an object plays. The 'Preparer' duck type from session 05 is such a role. Mechanic, Driver and TripCoordinator implement a prepare_trip method, which means that they can all play the Preparer role.

# NB that these roles are usually two sided. Just as we have Preparers, we also have a Preparable, which, in this case, is the Trip class. It implements the Preparable interface, which includes all of the messages that any Preparer might expect to send to a Preparable, such as the methods 'bikes', 'customer', vehicle.

# Modules allow us to define a named group of methods that are independent of class and can be mixed in to any object, thus allowing objects of different classes to play a common role using a single piece of code.

# When an object includes a module, the methods contained therein become available via automatic message delegation, thus expanding the range of messages that the object can respond to.

# CASE:

# At FastFeet, bikes have a minimum of one day's worth of 'downtime' needed after every trip for check and maintenance. Vehicles need 3 days between each trip, and mechanics need 4 days.

# Assume that a Schedule class exists with the interface:

# scheduled?(target, starting, ending)
# add(target, starting, ending)
# remove(target, starting, ending)

# Each method takes the target object (the object that we are checking) as well as the start and end dates for the period of interest. The Schedule class is responsible for knowing if the target object is already scheduled, as well as adding and removing target objects from the schedule.

# This is fine for checking if an object is NOT scheduled, but it can't yet tell if an object CAN be scheduled. Someone, somewhere, needs to take account of the rest period needed by different objects.

# Should this information be held by Schedule? If so, it would need to check the class of the object and respond accordingly.

class Schedule
  #..
  def schedulable?(target, starting, ending)
    if target.class == Bike
      lead_time = 1
    elsif target.class == Mechanic
      lead_time = 4
    elsif target.class == Vehicle
      lead_time = 3
    end
  end
  #..
end

# It should feel dirty to you that we're using conditionals, AND that the Schedule knows the lead time for different classes... There is clearly too much coupling here.

# So what should we do? We should turn the variable (lead_time) into a message that Schedule sends to the incoming object.

# NB, if we do that, then Schedule expects its 'target' to behave like something that responds to lead_time, that is, like something Schedulable. It looks like we've discovered a duck type.

