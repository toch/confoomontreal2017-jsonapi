# Require this file for feature tests on API
require_relative "spec_helper"

class MiniTest::Spec
  include Rack::Test::Methods

  def app
    Hanami.app
  end
end
