# Testing Outgoing Messages

# As discussed previously, outgoing messages are either QUERIES or COMMANDS.

# Query messages matter only to the object sending them, while command messages have effects that are visible to other objects in your application/

# YOU SHOULD IGNORE OUTGOING QUERY Messages

# Gear's 'gear_inches' method sends the diameter message to the wheel that was injected in to it on initialization. HOWEVER, the tests to prove the CORRECTNESS of the diameter calculation belong in WHEELs tests, NOT in Gear's tests.

# Gear is responsible for testing that gear_inches works properly, which it can do by testing that the method returns the appropriate results, NOT by testing the ACTUAL CALCULATION that the diameterizable object implements.

# HOWEVER

# In COMMAND messages, it DOES matter that a message gets sent, and so the object under test is responsible for sending the message and your tests must prove it does so.
