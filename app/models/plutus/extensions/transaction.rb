module Plutus
  module Extensions
    module Transaction
      extend ActiveSupport::Concern

      included do
        belongs_to :commercial_document, :polymorphic => true
        belongs_to :credit_account,      :class_name => "Plutus::Account"
        belongs_to :debit_account,       :class_name => "Plutus::Account"

        validates_presence_of :credit_account, :debit_account, :amount, :description
        validates_associated  :credit_account, :debit_account
      end
    end
  end
end
