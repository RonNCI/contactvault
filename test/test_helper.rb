ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module LoginTestHelpers
  def login_as(user)
    post login_path, params: { 
      session: { 
        email: user.email, 
        password: user.password 
      } 
    }
  end
end

class ActiveSupport::TestCase
  parallelize(workers: :number_of_processors)

  fixtures :all

  include LoginTestHelpers
end