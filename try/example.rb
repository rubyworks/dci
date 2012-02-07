require 'dci'

# Mixins are fixed rolls.
module Balance
  def initialize(account_id)
    @account_id = account_id
    @balance    = 0
  end
  def account_id
    @account_id
  end
  def available_balance
    @balance
  end
  def increase_balance(amount)
    @balance += amount
  end
  def decrease_balance(amount)
    @balance -= amount
  end
end

#
class Balance::TransferSource < Role
  def transfer(amount)
    decrease_balance(amount)
    puts "Tranfered $#{amount} from account ##{account_id}."
  end
end

#
class Balance::TransferDestination < Role
  def transfer(amount)
    increase_balance(amount)
    puts "Tranfered $#{amount} into account ##{account_id}."
  end
end

# We can think of a context as setting a scene.
class Balance::Transfer < Context
  role :source_account      => Balance::TransferSource
  role :destination_account => Balance::TransferDestination

  def initialize(source_account, destination_account)
    self.source_account      = source_account
    self.destination_account = destination_account
  end

  def transfer(amount)
    begin
      puts "Begin transfer."
      roles.each{ |role| role.transfer(amount) }
    end
    puts "Transfer complete."
  end
end

class Account
  # An account by definition has a balance.
  include Balance
end

acct1 = Account.new(000100)
acct2 = Account.new(000200)

Balance::Transfer.new(acct1, acct2).transfer(50)


