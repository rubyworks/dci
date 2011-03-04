require 'anise'
require 'facets/functor'

# Roll base class.
class Role
  def initialize(player)
    @player = player
  end
  # should be public send ?
  def method_missing(s, *a, &b)
    @player.__send__(s, *a, &b)
  end
end

# Context (UseCase) base class.
class Context
  include Anise
  attr :roles
  def self.cast(player, role)
    attr player, :role => role
  end
  def initialize
    @roles = []
  end
  def stage
    self.class.annotations.each do |player, anns|
      roles << anns[:role].new(__send__(player))
    end
    Functor.new do |fn, *a, &b|
      roles.each{ |player| player.__send__(fn, *a, &b) }
    end
  end
end


# --- example ---

# Mixins are fixed rolls.
module Balance
  def initialize
    @balance = 0
  end
  def availableBalance
    @balance
  end
  def increaseBalance(amount)
    @balance += amount
  end
  def decreaseBalance(amount)
    @balance -= amount
  end
end

#
class Balance::TransferSource < Role
  def transfer(amount)
    decreaseBalance(amount)
    puts "Tranfered from account #{__id__} $#{amount}"
  end
end

#
class Balance::TransferDestination < Role
  def transfer(amount)
    increaseBalance(amount)
    puts "Tranfered to account #{__id__} $#{amount}"
  end
end

# We can think of a context as setting a scene.
class Balance::Transfer < Context
  cast :source_account, Balance::TransferSource
  cast :destination_account, Balance::TransferDestination
  def initialize(source_account, destination_account)
    super()
    @source_account      = source_account
    @destination_account = destination_account
  end
  def transfer(amount)
    stage.transfer(amount)
  end
end

class Account
  # An account by definition has a balance.
  include Balance
end

acct1 = Account.new
acct2 = Account.new

Balance::Transfer.new(acct1, acct2).transfer(50)


