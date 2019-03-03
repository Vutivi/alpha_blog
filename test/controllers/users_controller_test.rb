require "test_helper"
class UsersControllerTest < ActionDispatch::IntegrationTest

   def setup
    @user = User.new(username: "john", email: "john@example.com", password: "p@ssword")
   end

end
