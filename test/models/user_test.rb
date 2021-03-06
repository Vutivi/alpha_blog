require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user  = User.new(email: "vutivi@alphablog.co.za",username: "vutivi-foo", password: "password")
    @user1 = User.new(email: "hope@alphablog.co.za",username: "hope-bar", password: "password")
    @category = Category.new(name: "sports")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.username = "      "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.username="a"*51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a"*244+"@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept all valid addresses" do
   valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]

   valid_addresses.each do |valid_address|
    @user.email = valid_address
    assert @user.valid?, "#{valid_address.inspect} should be valid"
   end
  end

  test "email validation should reject invalid addresses" do
   invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                          foo@bar_baz.com foo@bar+baz.com]
   invalid_addresses.each do |invalid_address|
     @user.email = invalid_address
     assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
   end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "associated articles should be destroyed" do
    @user.save
    @user.articles.create!(title: "Lorem ipsum", description: "Hey hey it's done.", user: @user)
    assert_difference 'Article.count', -1 do
      @user.destroy
    end
  end

  test "should follow and unfollow a user" do
    vutivi = @user
    hope   = @user1
    assert_not vutivi.following?(hope)
    vutivi.follow(hope)
    assert vutivi.following?(hope)
    assert hope.followers.include?(vutivi)
    vutivi.unfollow(hope)
    assert_not vutivi.following?(hope)
  end

end
