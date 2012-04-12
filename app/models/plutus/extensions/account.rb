module Plutus
  module Extensions
    module Account
      extend ActiveSupport::Concern

      included do
        has_many :credit_transactions, :class_name => 'Plutus::Transaction', :foreign_key => 'credit_account_id'
        has_many :debit_transactions,  :class_name => 'Plutus::Transaction', :foreign_key => 'debit_account_id'
      end

      module ClassMethods
        # The trial balance of all accounts in the system. This should always equal zero,
        # otherwise there is an error in the system.
        #
        # @example
        #   >> Account.trial_balance.to_i
        #   => 0
        #
        # @return [BigDecimal] The decimal value balance of all accounts
        def trial_balance
          raise NoMethodError, "undefined method 'trial_balance'" unless self == Plutus::Account
          
          Asset.balance - (Liability.balance + Equity.balance + Revenue.balance - Expense.balance)
        end
      end
    end
  end
end
