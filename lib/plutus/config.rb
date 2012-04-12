module Plutus
  class Config
    attr_accessor :orm

    def initialize(options = {}, &block)
      self.orm = options.delete(:orm)
    end

    def orm(orm=nil)
      @orm = orm if orm
      @orm ||= (defined?(Mongoid) && !defined?(ActiveRecord::Base)) ? :mongoid : :active_record
    end
  end
end

