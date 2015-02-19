# These are my notes from reading Sandi Metz' 'Practical Object Oriented Design in Ruby'. I hope it's as useful to read as it was to write:)

#=============================================================================================================
# TL:DR: Well designed applications are constructed of small, trustworthy, self-contained objects with minimal context, clear interfaces, and injected dependencies that are inherently reusable.
#=============================================================================================================

# Object oriented design requires that you shift from thinking of the world as a collection of predefined processes to modelling the world as a series of messages that pass between objects.

# Object oriented applications are made up of parts that interact to produce the behaviour of the whole. The parts are OBJECTS; interactions are embodied in MESSAGES that pass between them.

# Object oriented applications are made up of objects and the messages that pass between them.
# => People often focus too much on the objects, and not enough on the messages passing between them - probably because classes are more visible. In well designed applications, the latter ranks higher.

# Objects are instantiated instances of abstracts classes. They have behaviours (methods) and may contain data (variables), data to which they alone control access. Objects invoke one anothers behavious by sending each other MESSAGES

# OOD is about managing DEPENDENCIES

# A good developer should have the following in his TOOLBOX:

# SOLID:

# S.ingle responsibility
# O.pen-Closed
# L.iskov substitution
# I.nterface segregation
# D.ependency inversion

# DRY - Don't Repeat Yourself
# LoD - Law of Demeter

# DESIGN PATTERNS

#  AGILE & Iterative Development
#  Test Driven Development

# Other than that - your simplest rule of thumb should be Ockham's Razor - KEEP IT SIMPLE!
