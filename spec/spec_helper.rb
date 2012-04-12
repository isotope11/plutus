require 'bundler/setup'

$: << File.expand_path('../lib', __FILE__)
require 'plutus'
Plutus.orm = :active_record

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path('../dummy/config/environment', __FILE__)

require 'factory_girl'
require 'rspec/rails'

Dir[File.expand_path(File.join(File.dirname(__FILE__),'factories','**','*.rb'))].each {|f| require f}

RSpec.configure do |config|
  #config.use_transactional_fixtures = true

  config.after :each do
    Mongoid.master.collections.select do |collection|
      collection.name !~ /system/
    end.each(&:drop)
  end

end

