Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :mocha
end