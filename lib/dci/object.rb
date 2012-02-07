# Data - The data are "what the system is." The data part of the DCI architecture
# is its (relatively) static data model with relations. The data design is usually
# coded up as conventional classes that represent the basic domain structure of
# the system. These classes are barely smart data, and they explicitly lack the
# functionality that is peculiar to support of any particular use case. These
# classes commonly encapsulate the physical storage of the data. These data
# implement an information structure that comes from the mental model of end
# users, domain experts, programmers, and other people in the system. They may
# correspond closely to the model objects of MVC.
#
# An example of a data object could be a bank account. Its interface would have
# basic operations for increasing and decreasing the balance and for inquiring
# about the current balance. The interface would likely not offer operations that
# involve transactions, or which in any way involve other objects or any user
# interaction. So, for example, while a bank account may offer a primitive for
# increasing the balance, it would have no method called deposit. Such operations
# belong instead in the interaction part of DCI.
#
# Data objects are instances of classes that might come from domain-driven design,
# and such classes might use subtyping relationships to organize domain data.
# Though it reduces to classes in the end, DCI reflects a computational model
# dominated by object thinking rather than class thinking. Therefore, when
# thinking "data" in DCI, it means thinking more about the instances at run time
# than about the classes from which they were instantiated. 
#
#     class Account
#       def initialize(accountId)
#         @account_id = accountId
#         @balance    = 0
#       end
#       def account_id
#         @account_id
#       end
#       def available_balance
#         @balance
#       end
#       def increase_balance(amount)
#         @balance += amount
#       end
#       def decrease_balance(amount)
#         @balance -= amount
#       end
#     end
#
# @todo Should objects track the roles in which they are presently particiapting?
class Object
end
