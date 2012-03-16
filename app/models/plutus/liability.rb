module Plutus
  # The Liability class is an account type used to represents debts owed to outsiders.
  #
  # === Normal Balance
  # The normal balance on Liability accounts is a *Credit*.
  #
  # @see http://en.wikipedia.org/wiki/Liability_(financial_accounting) Liability
  #
  # @author Michael Bulat
  class Liability < Account

    # The credit balance for the account.
    #
    # @example
    #   >> liability.credits_balance
    #   => #<BigDecimal:103259bb8,'0.3E4',4(12)>
    #
    # @return [BigDecimal] The decimal value credit balance
    def credits_balance
      credit_transactions.inject(BigDecimal('0')) {|sum, credit_transaction| sum + credit_transaction.amount}
    end

    # The debit balance for the account.
    #
    # @example
    #   >> liability.debits_balance
    #   => #<BigDecimal:103259bb8,'0.1E4',4(12)>
    #
    # @return [BigDecimal] The decimal value credit balance
    def debits_balance
      debit_transactions.inject(BigDecimal('0')) {|sum, debit_transaction| sum + debit_transaction.amount}
    end

    # The balance of the account.
    #
    # Liability accounts have normal credit balances, so the debits are subtracted from the credits
    # unless this is a contra account, in which credits are subtracted from debits
    #
    # @example
    #   >> liability.balance
    #   => #<BigDecimal:103259bb8,'0.2E4',4(12)>
    #
    # @return [BigDecimal] The decimal value balance
    def balance
      if contra
        debits_balance - credits_balance
      else
        credits_balance - debits_balance
      end
    end

    # Balance of all Liability accounts
    #
    # @example
    #   >> Liability.balance
    #   => #<BigDecimal:1030fcc98,'0.82875E5',8(20)>
    def self.balance
      accounts_balance = BigDecimal.new('0')
      accounts = self.find(:all)
      accounts.each do |liability|
        if liability.contra
          accounts_balance -= liability.balance
        else
          accounts_balance += liability.balance
        end
      end
      accounts_balance
    end
  end
end
