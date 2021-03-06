require "bundler/setup"
require "lichess"
require "pry"
require "dotenv"

def valid_token
  valid_token ||= ENV["LICHESS_TOKEN"]
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  Dotenv.load
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
