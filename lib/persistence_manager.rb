module Plutus
  class PersistenceManager
    @@persistence_plugin = :activerecord
    @@persistence_plugins = {:activerecord => ActiveRecord::Base}

    def self.persistence_class
      raise "Persistence Layer not supported" unless @@persistence_plugins.keys.include? @@persistence_plugin
      @@persistence_plugins[@@persistence_plugin]
    end

    def self.set_persistence_plugin persistence_plugin
      @@persistence_plugin = persistence_plugin
    end

    def self.persistence_plugin
      @@persistence_plugin
    end

    def self.register_persistence_plugin persistence_plugin, klass
      @@persistence_plugins[persistence_plugin] = klass
    end
  end
end
