RSpec.configure do |config|
  config.color = true
  config.tty = true
  config.formatter = :documentation

  config.mock_with :rspec do |mocks|
    mocks.verify_doubled_constant_names = true
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
end
