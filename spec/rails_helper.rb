ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require "shoulda/matchers"

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

Capybara.javascript_driver = :webkit
Capybara.configure do |config|
  config.match = :prefer_exact
  config.ignore_hidden_elements = true
end

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.use_instantiated_fixtures  = false
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.filter_rails_from_backtrace!
  config.infer_spec_type_from_file_location!
end
