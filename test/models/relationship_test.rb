require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase

  def setup
    @user  = User.create(email: "vutivibar@alphablog.co.za",username: "vutivi-bar", password: "password")
    @user1 = User.create(email: "vutivi@alphablog.co.za",username: "vutivi-foo", password: "password")
    @relationship = Relationship.new(follower_id: @user.id,
                                     followed_id: @user1.id)
  end

  test "should be valid" do
    assert @relationship.valid?
  end

  test "should require a follower_id" do
    @relationship.follower_id = nil
    assert_not @relationship.valid?
  end

  test "should require a followed_id" do
    @relationship.followed_id = nil
    assert_not @relationship.valid?
  end
end
