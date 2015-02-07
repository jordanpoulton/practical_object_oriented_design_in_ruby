# Law of Demeter

# Now that we have a decent domain model, how would you instruct the Customer to start riding a bike?

# If you answered:

# customer.bike.wheel.rotate

# You'd be breaking the Law of Demeter, which basically says that objects should not reach THROUGH other objects to get the code execution they want.

# Put simply, Demeter says - "Only talk to your neighbours"

# If you were to use the code above, it relies on the link between customer and bike and wheel, and on wheel having the method 'rotate'. A customer would need to have a bike, which would need to have a wheel, which would need to have the method 'rotate'. That's a lot of dependency. If anything were to change, the whole thing would break, and it wouldn't be obvious why.

# It would be much better to encapsulate the action at each step in the chain, so you would want to use something like:

# customer.depart

# And wrap each interaction up in its own, encapsulated method.

# As a result, the customer would be asking for WHAT he wants, not instruting HOW to achieve what he wants, and if and when a change is made to the underlying code, it would be a lot clearer as to WHERE the issue was causing the message to fail.
