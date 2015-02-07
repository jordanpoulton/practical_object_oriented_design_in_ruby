# Design is more the art of preserving changeability than it is the act of achieving perfection.

# You define easy to change as:

# Changes have no unexpected side effects
# Small changes in reuirements require correspondingly small changes in code
# Existing code is easy to reuse
# The easiest way to make a change is to add code that in itself is easy to change

# Your code should be TRUE:

# Transparent - changes should be obvious and have obvious repercussions
# Reasonable - the cost of any change should be proportional to the benefits it achieves
# Usable - Existing code should be useable in new and unexpected contexts
# Exemplary - the code itself should encourage those who change it to perpetuate its qualities

# Single Reponsibility:
# A class should do the smallest possible useful thing.

# Bicylces and Gears
# Gears are calculated by the ratio of the chainring (the gears at the peddle) to the cog (the gear on the rear wheel).

chainring = 52
cog = 11
ratio = chainring / cog.to_f
puts ratio # => 4.72
# Hard gear - one turn of your feet outputs almost 5 turns of the rear wheel


chainring = 30
cog = 27
ratio = chainring / cog.to_f
puts ratio # => 1.1
# Easy gear - one turn of your feet outputs just over 1 turn of the rear wheel

# If you wanted to model this interaction, you look for the NOUNS and find BiCYCLES and GEARS.
# BUT - there is no behavious defined for a bicycle yet, so we just start with the Gear class

class Gear
  attr_reader :chainring, :cog
  def initialize(chainring, cog)
    @chainring = chainring
    @cog = cog
  end

  def ratio
    chainring / cog.to_f
  end
end

puts Gear.new(52, 11).ratio
puts Gear.new(30, 27).ratio

# But what about if we have a new requirement that the size of the wheel is taken into account in our equation? You would need to calculate 'Gear Inches', which is the product of wheel diameter (rim diameter + 2 * tire diameter) and the gear ratio
# But what about if we have a new requirement that the size of the wheel is taken into account in our equation? You would need to calculate 'Gear Inches', which is the product of wheel diameter (rim diameter + 2 * tire diameter) and the gear ratio. How would you code this?
