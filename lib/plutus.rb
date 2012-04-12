require 'rails'
require 'plutus/engine'
require 'plutus/config'

module Plutus
  class << self
    def configure(options = {}, &block)
      @config ||= Plutus::Config.new(options, &block)
    end

    def config
      @config ||= Plutus::Config.new
    end

    def method_missing(meth, *args)
      super unless config.respond_to?(meth)
      config.send(meth, *args)
    end
  end

  class OrmNotSupportedError < StandardError; end
end

