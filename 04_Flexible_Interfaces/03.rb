# Remember the use case for the problem...

# A customer, in order to choose a trip, would like to see a list of available trips of appropriate difficulty, on a specific date, where rental bikes are available


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


# In this model, the customer knows way too much about what makes a trip suitable. It's reasonable that the customer sends the suitable trips method. The problem is with the receiver.

# We need an object that embodies the intersection between a Customer, a Trip and a Bike. How about a TripFinder class?

|----------|                                                                                  |--------|
|Customer  |----------------------------------------------------------------------------------|Customer|
|----------| |                                                                        ^       |--------|
             |                                                                        |
             |suitable_trips(on_date, of_difficulty, need bike)                       |*returns a Trip
             |                                                                        |
|----------|\ /      |-------------------|                                            |       |--------|
|TripFinder|---------|for each trip found|----------------------------------------------------| Trip   |
|----------|    |  ^ |-------------------|                                      |  ^          |--------|
                |suitable_trips(on_date, of_difficulty)                         |  |
                |  |                                                            |  |
|--------|     \|/ |*returns a Trip         suitable_bike(trip_date, route_type)|  |          |--------|
|  Trip  |------------------------------------------------------------------------------------| Bike   |
|--------|                                                                      |  |          |--------|
                                                                                |  |*returns a Bike
|--------|                                                                     \|/ |          |--------|
|  Bike  |------------------------------------------------------------------------------------| Trip   |
|--------|                                                                                    |--------|


# Now we're starting to have a nicely designed model


