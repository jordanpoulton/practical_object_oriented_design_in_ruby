# You shouldn't need to be told the benefits of testing... So I'm going to skip this part and assume that, like me, you think TDD rocks.

# But the question of WHAT to test, and HOW to design efficient tests, is pertinent.

# Tests should concentrate on the incoming or outgoing messages that cross an object's boundaries. The incoming messages make up the public interface of the receiving objects. The outoging messages, by definition, are incoming into other objects and so are part of another object's interface.

# Since incoming messages define the object's interface, all incoming messages should be tested, and tested for state.

# Outgoing messages come in 2 types:

# Query messages have no side effects and thus matter only to their sender. The sender obviously cares that it gets the right message BACK, but no other part of the application cares that the message itself is actually sent. Messages like this are called QUERIES and do not need to be tested by the sending object. This is because query messages are part of the public interface of the RECEIVER, which will already have tests of its own.

# Command messages DO have side effects (a file gets written, a database record is saved, an action is taken by an observer), and your application depends on these outcomes. These messages are COMMANDS and its the sending object's responsibility that they are properly sent.Proving that a message is sent is a test of BEHAVIOUR, not one of state, and will involve assertions about the number of times the message is sent, and with which arguments. Outgoing message tests should not test the state change of the receiver. It is up the receiver to have a test that tests for internal state change in response to an incoming message.

# So, your guidelines should be:

# Incoming messages should be tested for the state they return
# Outgoing Command messages should be tested to ensure that they get sent, and to verify their BEHAVIOUR in the sending process
# Outgoing Query messages should not be tested

#Remember though - just as you don't want your code to be too tightly coupled, you don't want your tests to be too tightly coupled to your code either!!
