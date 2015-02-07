# Object oriented applications are MADE UP of classes but DEFINED BY messages

# Objects communicate via their INTERFACES

# If you go to a restaurant and order food, you don't tell them how to cut the vegetables and what spices to use. You just order your food and trst them to send you the food you want.

# The menu acts as a kind of public interface.

# You ask for WHAT you want. You don't tell them HOW to give you what you want.

# Each of your classes should be like the kitchen.

# The methods in a public interface should:

# Reveal its primary responsibility
# Are expectd to be invoked by others
# Will not change on a whim
# Are safe for others to depend on
# Are thoroughly documented in tests

# By contrast, the private methods:

# Handle implementation details
# Are not expected to be sent by other objects
# Can change for any reason whatsoever
# Are unsafe for others to depend on
# May not even be referenced in tests
