# New Scenario:

# Imagine a game where players race virtual bikes. The bikes have gears. The Gear class is responsible for letting the application know when a player changes gears so the application can update the Bike's behaviour.

# In the following code, we add an observer class to Gear:

class Gear
  attr_accessor :chainring, :cog, :wheel, :observer
  def initialize(options)
    @chainring = options[:chainring]
    @cog = options[:cog]
    @wheel = options[:wheel]
    @observer = options[:observer]
  end

  def set_cog(new_cog)
    @cog = new_cog
    changed
  end

  def set_chainring(new_chainring)
    @chainring = new_chainring
    changed
  end

  def changed
    observer.changed(chainring, cog)
  end
end

# When a player shifts gear, the set_cog or set_chainring methods execute. These methods save the new value then invoke Gear's 'changed' method, which then passes the current chainring and cog settings to the observer.

# Part of Gear's responsibility now is to notify the observer whenever a change in state of either cogs or chainrings. Your tests should now verify that these messages get sent.

# NOT ONLY should it prove that the message is sent, it should do so without making any assertions about WHAT the observers 'changed' method returns. This state change is Observer's responsibility. The responsibility for testing a message's return values lies with its receiver. To do this - you need a Mock.

# See 07_spec.rb
