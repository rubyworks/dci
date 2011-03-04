class Account
  def self.find(accountID)
    @@accunts[accountID]
  end

  attr :accountID
  attr :balance

  def initialize(accountID, initialBalance)
    @@accounts[accountID] = self

    @accountID = accountID
    @balance = initialBalance
  end
end

class SavingsAccount < Account
  def initialize(accountID, initialBalance)
    super(accountID, initialBalance)
  end

  def availableBalance; @balance; end
  def decreaseBalance(amount); @balance -= amount; end
  def increaseBalance(amount); @balance += amount; end

  def updateLog(message, time, amount)
  end
end

class TransferMoneyContext
  attr :source_account
  attr :destination_account
  attr :amount
  def initialize(amt, sourceID, destID)
    @source_account = Account.find(sourceID)
    @source_account.extend TransferMoneySource
    @destination_account = Account.find(destID)
    @amount = amt
  end
  def execute
    execute_in_context do
      source_account.transferTo
    end
  end
  def self.execute(amt, sourceID, destID)
    TransferMoneyContext.new(amt, sourceID, destID).execute
  end
end

module TransferMoneySource
  include ContextAccessor
  def transferTo
    raise "Insufficiant Funds" if balance < context.amount
    withdraw context.amount
    context.source_account.deposit context.amount
    updateLog "Transfer Out", Time.now, context.amount
    context.source_account.updateLog "Transfer In", Time.now, context.amount
  end
end

