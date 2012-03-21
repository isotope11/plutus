# Plutus
require "rails"
load 'lib/persistence_manager.rb'
module Plutus
  class Engine < Rails::Engine
    isolate_namespace Plutus
  end
end
