# Meet FastFeet Inc, a bicycle touring company that offers trips on Road Bikes and Mountain Bikes.
# Each trip follows a specific route, and may occur several times in a year. There is a limit to the number of customers who can go on a trip and each trip requires a specific number of guides who double as mechanics.
# Each route is rated according to its aerobic difficulty, Mountain bike trips have a rating that reflects technical ability, and customers have an aerobic fitness level and a Mountain Bike technical skill level that determines if a trip is right for them.
# Rental bikes come in various sizes and are suitable for either road or mountain trips.

# Look for nouns and verbs! These are often a good place to start when constructing a domain model.

# It can help to draw sequence diagrams, as they describe the objects and the messages that pass between those objects


|--------|               |--------|
|Customer|---------------|Customer|
|--------|      |     ^  |--------|
                |     |
                |suitable_trips(on_date, of_difficulty, need_bike)
                |     |*return a Trip
|--------|     \ /    |  |--------|
|  Trip  |---------------| Trip   |
|--------|               |--------|


# Here, the customer sends a message to trips, asking for a list of suitable trips, passing information about the date, the difficulty and whether he needs a bike or not.

# But, immediately this looks fishy. The Trip is responsible for getting a bike to the customer, and it's not obvious, or even very reasonable, to expect the trip receiver to respond to this message.

# This transition from CLASS BASED design to MESSAGE BASED DESIGN is critical.

# Don't say "I know I need this class, what should it do".. Say - "I need to send this message - who should respond to it."

# It's feasible for the customer to send the suitable trips method, but Trips shouldn't be figuring out bicyles. Maybe we should have a bicycle class for that?

|--------|               |-------------------|                                |--------|
|Customer|---------------|for each trip found|--------------------------------|Customer|
|--------| |   ^         |-------------------|        |  ^                    |--------|
           |   |                                      |  |
           |suitable_trips(on_date, of_difficulty)    |suitable_bike(trip_date, route_type)
           |   |*returns a Trip                       |  |*returns a Bike
|--------|\ /  |                                      |  |                    |--------|
|  Trip  |--------------------------------------------------------------------| Trip   |
|--------|                                            |  |                    |--------|
                                                      |  |
|--------|                                           \ / |                    |--------|
|  Bike  |--------------------------------------------------------------------| Bike   |
|--------|                                                                    |--------|

# This format moves some of the responsibilities out of Trip, but it merely transfers them to Bike.
# Remembering our Kitchen analogy - the customer knows not only WHAT he wants, but HOW the objects should collaborate to get it to him - he's not ordering off a menu. He's going into the kitchen and cooking the meal.


# let's look at a new example - the trip/bike/mechanic model

|--------|                                                                     |--------|
|Mechanic|---------------------------------------------------------------------|Mechanic|
|--------|                         ^ |   ^  |    ^   |        ^   |            |--------|
                                   | |   |  |    |   |        |   |
            ___         clean_bikes| |   |  |    |lube_chain  |check_brakes
           |   |                   | |   | \|/   |   |        |   |
|--------| |  \ /  |-------------| |\|/  |pump_tires\|/       |  \|/            |--------|
|  Trip  |---------|for each bike|----------------------------------------------| Trip   |
|--------|  bikes  |-------------|                                              |--------|

# Here, trip knows way too much about what a mechanic is supposed to do... It's very procedural
# It would be much better just to ask the mechanic to prepare the bike, leaving the details to him

                                         ____________________
                                        |   clean_bikes etc  |
|--------|                              |                   \|/                |--------|
|Mechanic|---------------------------------------------------------------------|Mechanic|
|--------|                           ^                           |             |--------|
                                     |                           |
       bikes___    prepare_bike(bike)|                           |*returns a Bike
           |   |                     |                           |
|--------| |  \ /    |-------------| |                          \|/             |--------|
|  Trip  |-----------|for each bike|--------------------------------------------| Trip   |
|--------|           |-------------|                                            |--------|


# Now the HOW of preparing a bicycle has been ceded to Mechanic.
# However, Trip expects to have a mechanic object, and Trip also needs him to respond to the prepare_bike(bike) message.
# This is the object's CONTEXT
# You should keep objects as independent from context as you possibly can. It makes them easier to reuse and less dependent on other objects, more able to collaborate with others without knowing who they are or what they do. (One of the way that this can be achieved is through dependency injection). In this instance, you would inject a mechanic into a trip to maintain context independence.


                                                         ______________
                                                        | prepare_bike |
|--------|                             |-------------|  |             \|/        |--------|
|Mechanic|-----------------------------|for each bike|---------------------------|Mechanic|
|--------|                   ^   |  /|\|-------------|                        |  |--------|
                             |  bikes|                                        |
           prepare_trip(self)|   |   |                                        |*returns prepared bikes
                             |   |   |*returns a Bike                         |
|--------|                   |  \|/  |                                       \|/|--------|
|  Trip  |----------------------------------------------------------------------| Trip   |
|--------|                                                                      |--------|



# Now this is starting to look like Object Oriented Design







