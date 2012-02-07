# Context - The Context is the class (or its instance) whose code includes the roles
# for a given algorithm, scenario, or use case, as well as the code to map these
# roles into objects at run time and to enact the use case. Each role is bound
# to exactly one object during any given use case enactment; however, a single
# object may simultaneously play several roles. A context is instantiated at the
# beginning of the enactment of an algorithm, scenario, or use case. In summary,
# a Context comprises use cases and algorithms in which data objects are used
# through specific Roles.
#
# Each context represents one or more use cases. A context object is instantiated
# for each enactment of a use case for which it is responsible. Its main job
# is to identify the objects that will participate in the use case and to
# assign them to play the Roles which carry out the use case through their
# responsibilities. A role may comprise methods, and each method is some small
# part of the logic of an algorithm implementing a use case. Role methods run
# in the context of an object that is selected by the context to play that role
# for the current use case enactment. The role-to-object bindings that take place
# in a context can be contrasted with the polymorphism of vernacular object-oriented
# programming. The overall business functionality is the sum of complex, dynamic
# networks of methods decentralized in multiple contexts and their roles.
#
# Each context is a scope that includes identifiers that correspond to its roles.
# Any role executing within that context can refer to the other roles in that
# context through these identifiers. These identifiers have come to be called
# methodless roles. At use case enactment time, each and every one of these
# identifiers becomes bound to an object playing the corresponding Role for
# this Context.
#
# An example of a context could be a wire transfer between two accounts,
# where data models (the banking accounts) are used through roles named
# SourceAccount and # DestinationAccount. 
#
#     class Balance::Transfer < Context
#       role :source_account      => Balance::TransferSource
#       role :destination_account => Balance::TransferDestination
#
#       def initialize(source_account, destination_account)
#         self.source_account      = source_account
#         self.destination_account = destination_account
#       end
#
#       def transfer(amount)
#         roles.each{ |role| role.transfer(amount) }
#       end
#     end
#
class Context

  # Define a role given the name the role will use in this context,
  # and the role class that is to be played.
  #
  def self.role(name_to_role)
    name_to_role.each do |name, role|
      define_method("role_#{name}"){ role }

      module_eval %{
        def #{name}=(data)
          @#{name} = role_#{name}.new(data)
        end

        def #{name}
          @#{name}
        end
      }
    end
  end

  # The default contructor can be used to assign roles via
  # a settings hash.
  #
  def initialize(settings={})
    settings.each do |k,v|
      __send__("#{k}=", v)
    end
  end

  # Returns a list of all roles in the context.
  def roles
    list = []
    methods.each do |name|
      next unless name.to_s.start_with?('role_')
      list << __send__(name.to_s.sub('role_',''))
    end
    list
  end

end
