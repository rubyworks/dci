# Context

Let's setup a very simple example to run some tests.

    class ExampleObject
      def say_anything
        "anything"
      end
    end

    class ExampleRole < DCI::Role
      def say_anything
        @self.say_anything
      end
    end

    class ExampleContext < DCI::Context
      role :player => ExampleRole

      def initialize(player)
        self.player = player
      end

      def say_anything
        roles.each{ |role| role.say_anything }
      end
    end

So lets make sure the roles are listed.

    ExampleContext.roles  #=> [:player]

Now if subclass the ExampleContext and added a new roll,

    class AlternateContext < ExampleContext
      role :fanboy => ExampleRole
    end

Then both roles should be in the the list.

    AlternateContext.roles  #=> [:fanboy, :player]


