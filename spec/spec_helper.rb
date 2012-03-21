require 'factory_girl'

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path(File.dirname(__FILE__) + "/../fixture_rails_root/config/environment")
require Rails.root.join('db/schema').to_s if Plutus::PersistenceManager.persistence_plugin == :activerecord
require 'rspec/rails'

$: << File.expand_path(File.dirname(__FILE__) + '/../lib/')
require 'plutus'

Dir[File.expand_path(File.join(File.dirname(__FILE__),'factories','**','*.rb'))].each {|f| require f}

RSpec.configure do |config|
  #config.use_transactional_fixtures = true
end
