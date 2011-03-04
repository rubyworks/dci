  #
  class Account
    def self.accounts
      @@accounts ||= {}
     end
   
    def self.find(accountID)
      accounts[accountID]
    end

    attr :accountID
    attr :balance

    def initialize(accountID, initialBalance)
      Account.accounts[accountID] = self

      @accountID = accountID
      @balance = initialBalance
    end
  end

  #
  class SavingsAccount < Account
    def initialize(accountID, initialBalance)
      super(accountID, initialBalance)
    end

    def availableBalance; @balance; end
    def decreaseBalance(amount); @balance -= amount; end
    def increaseBalance(amount); @balance += amount; end

    def updateLog(message, time, amount)
      puts "%s %s #%s $%.2f" % [message, time, accountID, amount.to_f]
    end
  end

  # Use Case (Context)
  class MoneyTransfer
    attr :amount
    attr :source_account
    attr :destination_account

    def initialize(amt, sourceID, destID)
      @amount = amt
      @source_account = Account.find(sourceID)
      @destination_account = Account.find(destID)
    end

    def execute
      source_account.extend TransferSource
      destination_account.extend TransferDestination

      source_account.withdraw(amount)
      destination_account.deposit(amount)

      #source_account.unextend TransferSource
      #destination_account.unextend TransferDestination
    end
  end

  # Account Role
  module TransferSource
    def withdraw(amount)
      raise "Insufficiant Funds" if balance < amount
      decreaseBalance(amount)
      updateLog "Transfer Out", Time.now, amount
    end
  end

  # Account Role
  module TransferDestination
    def deposit(amount)
      increaseBalance(amount)
      updateLog "Transfer In", Time.now, amount
    end
  end

  SavingsAccount.new(1, 500)
  SavingsAccount.new(2, 100)

  transfer_case = MoneyTransfer.new(50, 1, 2)
  transfer_case.execute

