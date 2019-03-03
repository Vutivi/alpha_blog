require 'test_helper'

class RelationshipsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user  = User.new(email: "vutivi@alphablog.co.za",username: "vutivi-foo", password: "password")
    @user1 = User.new(email: "hope@alphablog.co.za",username: "hope-bar", password: "password")

    @relationship = @user.follows(@user1)
  end

  test "create should require logged-in user" do
    assert_no_difference 'Relationship.count' do
      post relationships_path
    end
    assert_redirected_to sign_in_path
  end

  test "destroy should require logged-in user" do
    assert_no_difference 'Relationship.count' do
      delete relationship_path(@relationship)
    end
    assert_redirected_to sign_in_path
  end
end
