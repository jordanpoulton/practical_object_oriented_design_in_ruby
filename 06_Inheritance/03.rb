# The style variable divides Bikes into two different catergories of thing... :road and :mountain. The types share a lot of features and behaviour, but differ in a number of ways. Some of Bike's behaviour applies to all bikes, some only to road bikes and some only to mountain bikes.

# This is the problem that inheritance solves - that of highly related types that share common behaviour but differ along some dimension.

# Put simply, objects receive messages, and when an object receives a message, it will either respond to that message if it contains a corresponding method, or it will pass that message up it's inheritance tree.

# If you don't specify a class that your class inherits from, it inherits from Object by default. Every class you create is, by definition, a subclass of something, even if you don't specify it explicitly.

# One other thing you should know - unlike some languages, Ruby only allows for single inheritance. For instances where you want something like multiple inheritance there are modules. We'll get to them later.

p nil.class
p nil.class.class
p String.class
p "Jordan".class
p String.ancestors

# Inheritance can be seen as a form of specialization, and is usually recognized by describing an "Is a" relationship. For example, if you have an Animal class, then Mammal, Bird and Fish potentially could inherit from it. You could then have a Human inherit from the Mammal class, but it's unlikely you'd have a class 'Alien' that could inherit from any of them (even if there were some shared characteristics... Let's not get side-tracked).

# In our example, RoadBike and MountainBike are specializations of Bike, so they seem to be good candidates for inheritance.

# Let's make a first attempt at this inheritance then:
require_relative "./01"

class MountainBike < Bike # This < is the code for 'inherits from'
  attr_reader :front_shock, :rear_shock

  def initialize(args)
    @front_shock  = args[:front_shock]
    @rear_shock   = args[:rear_shock]
    super(args)
  end

  def spares
    super.merge(rear_shock: rear_shock)
  end
end

bike = MountainBike.new(
  size: 'S',
  front_shock: 'Manitou',
  rear_shock: 'Fox'
  )

# You should note that BECAUSE we have created initialize and spares methods in the subclass MountainBike, these will OVERRIDE the methods in the parent class, Bike. We send 'super', which means we want to execute the code that we have added but continue by passing the message (either initialize or spares) up to the parent class and invoke the code contained there as well.

# The problem we have though is that our MountainBike is acting a little funny: (remember, we're inheriting from the bike class in 06_Inheritance/01.rb, as per the require command on line 22)


bike.spares # => {:chain=>"10 speed", :tire_size=>"23", :tape_color=>"red"}

# It has skinny tires and handlebar tape, which isn't right for a MountainBike. Basically, because RoadBike and MountainBike behaviour is in the superclass, the MountainBike subclass is now inheriting behaviour it shouldn't be. As written, Bike should not act as a superclass for MountainBike. We need to also take out the behaviour in the Bike class that is specific to RoadBikes.

# The way to do this is to take ALL of the code out of Bike and put it into RoadBike, and then only move back up the behaviour that is shared between MountainBikes and RoadBikes:

class Bike
end

class RoadBike < Bike
  attr_reader :size, :tape_color

  def initialize(args)
    @size       = args[:size]
    @tape_color = args[:tape_color]
  end

  def spares
    {chain: '10 speed',
      tire_size: '23',
      tape_color: tape_color
    }
  end
  #...
end

class MountainBike < Bike # This < is the code for 'inherits from'
  attr_reader :front_shock, :rear_shock

  def initialize(args)
    @front_shock  = args[:front_shock]
    @rear_shock   = args[:rear_shock]
    super(args)
  end

  def spares
    super.merge(rear_shock: rear_shock)
  end
end

