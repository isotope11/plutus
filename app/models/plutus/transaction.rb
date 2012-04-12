module Plutus
  # Transactions are the recording of debits and credits to various accounts.
  # This table can be thought of as a traditional accounting Journal.
  #
  # Posting to a Ledger can be considered to happen automatically, since
  # Accounts have the reverse 'has_many' relationship to either it's credit or
  # debit transactions
  #
  # @example
  #   cash = Asset.find_by_name('Cash')
  #   accounts_receivable = Asset.find_by_name('Accounts Receivable')
  #
  #   Transaction.create(:description => "Receiving payment on an invoice" ,
  #                      :debit_account => cash,
  #                      :credit_account => accounts_receivable,
  #                      :amount => 1000)
  #
  # @see http://en.wikipedia.org/wiki/Journal_entry Journal Entry
  #
  # @author Michael Bulat

  case Plutus.orm.to_sym
  when :active_record
    class Transaction < ActiveRecord::Base
      include Extensions::Transaction
    end
  when :mongoid
    class Transaction
      include Mongoid::Document
      include Mongoid::Timestamps
      include Extensions::Transaction
      field :description, :type => String
      field :credit_account_id, :type => Integer
      field :debit_account_id, :type => Integer
      field :amount, :type => BigDecimal
      field :commercial_document_id, :type => Integer
      field :commercial_document_type, :type => String
    end
  end
end
