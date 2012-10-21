require 'facets'

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |f| require f }
Dir[File.dirname(__FILE__) + '/prisoners/*.rb'].map { |f| require(f) }
