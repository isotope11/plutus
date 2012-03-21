module Plutus
  class MongoidPersistence
    include Mongoid::Document
    field :name,        :type => String
    field :type,        :type => String
    field :contra,      :type => Boolean
    field :created_at,  :type => DateTime
    field :updated_at,  :type => DateTime
  end
end
