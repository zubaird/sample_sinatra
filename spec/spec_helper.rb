ENV['RACK_ENV'] = 'test'

require_relative File.join('..', 'my_app')

RSpec.configure do |config|
  include Rack::Test::Methods

  def app
    MyAppController
  end
end
