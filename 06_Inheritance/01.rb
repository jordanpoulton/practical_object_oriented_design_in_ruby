# At its core, inheritance is a mechanism for AUTOMATIC MESSAGE DELEGATION. It defines a forwarding path for not-understood messages. It defines relationships such that, if one object cannot respond to a received message, it delegates that message to another. When you define inheritance, the message is forward up the inheritance tree automatically.

# In the FastFeet example, Bikes have a size, a handlebar tape colour, a tire size, and a chain type. At the start, there is only 1 type of bike:

class Bike
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

bike = Bike.new(
  size: 'M',
  tape_color: 'red'
  )

p bike.size
p bike.spares

# Let's say that FastFeet decide to start stocking Mountain Bikes as well as the Road Bikes above... They are similar, but different. They have sturdier frames, fatter tires, straight handlebars, different handlebar tape and forks for suspension. Our task is to accommodate Mountain and Road bikes in our design.

# How would you do it?
