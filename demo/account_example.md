# Account Balance Transfer

The Account Balance Transfre is the classic example of using DCI.

First we need our Data model. In the example that is the Account class.
To keep our example simple we will initialize new accounts with
a balance of $100. (We're generous like that.)

    class Account
      def initialize(account_id)
        @account_id = account_id
        @balance    = 100
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

We set up two Roles, one role for withdrawing money from an account,
and one for depositing money into an account.

    class Balance::TransferWithdraw < Role
      def transfer(amount)
        decrease_balance(amount)
        puts "Tranfered $#{amount} from account ##{account_id}."
      end
    end

    class Balance::TransferDeposit < Role
      def transfer(amount)
        increase_balance(amount)
        puts "Tranfered $#{amount} into account ##{account_id}."
      end
    end

Now we create a Context which will assign accounts to the roles
and used to perfomr the transfer.

    # We can think of a context as setting a scene.
    class Balance::Transfer < Context
      role :source_account      => Balance::TransferWithdraw
      role :destination_account => Balance::TransferDeposit

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

Let's give it a try.

    acct1 = Account.new(000100)
    acct2 = Account.new(000200)

    Balance::Transfer.new(acct1, acct2).transfer(50)

    acct1.available_balance  #=>  50
    acct2.available_balance  #=> 150

