# Use Inheritance for IS-A relationships
# In obvious cases where the sub class is a specialization of the super class, where they fall into a natural hierarchy of type, and where they follow the Liskov Substitution Principle - that the sub could be switched in for the super with no errors in the applications functionality

# Use duck types for BEHAVES-LIKE-A relationships
# Where you want many objects to play a common role, like schedulable, preparable, printable, persistable etc

# Use composition for HAS-A relationships
# When the sub is considered to belong to the super. Also, when the super is composed of the subs, but amounts to more than the sum of its subs. A bike has parts, but it is more than the sum of its parts.
