# Interaction - The Interaction is "what the system does." The Interaction
# is implemented as Roles which are played by objects at run time. These objects
# combine the state and methods of a Data (domain) object with methods (but no
# state, as Roles are stateless) from one or more Roles. In good DCI style,
# a Role addresses another object only in terms of its (methodless) Role. There
# is a special Role called `@self` which binds to the object playing the current
# Role. Code within a Role method may invoke a method on `@self` and thereby
# invoke a method of the Data part of the current object. One curious aspect
# of DCI is that these bindings are guaranteed to be in place only at run time
# (using a variety of approaches and conventions; C++ templates can be used to
# guarantee that the bindings will succeed). This means that Interactions—the
# Role methods—are generic. In fact, some DCI implementations use generics or
# templates for Roles.
#
# A Role is a stateless programming construct that corresponds to the end user's
# mental model of some entity in the system. A Role represents a collection of 
# responsibilities. Whereas vernacular object-oriented programming speaks of
# objects or classes as the loci of responsibilities, DCI ascribes them to Roles.
# An object participating in a use case has responsibilities: those that it takes
# on as a result of playing a particular Role.
#
# In the money transfer use case, for example, the role methods in the
# SourceAccount and DestinationAccount enact the actual transfer.
#
#     class Account::TransferWithdraw < Role
#       def transfer(amount)
#         decrease_balance(amount)
#         log "Tranfered from account #{account_id} $#{amount}"
#       end
#     end
#
#     class Account::TransferDepoit < Role
#       def transfer(amount)
#         increase_balance(amount)
#         log "Tranfered into account #{account_id} $#{amount}"
#       end
#     end
#
class Role

  #
  def initialize(player)
    @self = player
  end

  #
  # @todo Should use #public_send?
  def method_missing(s, *a, &b)
    @self.__send__(s, *a, &b)
  end

end

