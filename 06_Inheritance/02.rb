class Bike
  attr_reader :style, :size, :tape_color, :front_shock, :rear_shock

  def initialize(args)
    @style       = args[:style]
    @size        = args[:size]
    @tape_color  = args[:tape_color]
    @front_shock = args[:front_shock]
    @rear_shock  = args[:rear_shock]
  end

  def spares
    if style == :road
      {chain: '10 speed',
        tire_size: '23',
        tape_color: tape_color
      }
    else
      {chain: '10 speed',
        tire_size: '2.1',
        rear_shock: rear_shock
      }
    end
  end
  #...
end

bike = Bike.new(
  style: :Mountain,
  size: 'S',
  front_shock: 'Manitou',
  rear_shock: 'Fox'
  )

p bike.size
p bike.spares

# That if statement is kinda smelly isn't it?! If you add new styles, you'll need to extend the if statement, and there is now duplication on each of the conditional branches

# The small here is: 'The code contains an if statement that check an attribute that holds the category of self to determine what message to send to self' - even the sentence sounds muddled. That's because the code is muddled. And it should remind you of the duck type in the last session.

# But this time we aren't going to solve the problem by creating a ducktype. This time the pattern indicates a missing subtype, better known as a SUBCLASS

# One other smell that might help guide you in future... The @style attribute could just as easily have been called :type or :category - this implies that the various conditional statements apply to different sub categories of the parent class, which means you want to use inheritance to create SUBCLASSES
