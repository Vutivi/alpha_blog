require 'test_helper'

class ListCategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @category   = Category.create(name: "sports")
    @category2  = Category.create(name: "science")
    @admin_user = User.create(username: "john", email: "john@example.com", password: "p@ssword", admin: true)
  end

  test "should show categories listing" do
    sign_in_as(@admin_user, "p@ssword")
    get categories_path
    assert_template "categories/index"
    assert_select "a[href=?]", category_path(@category), text: @category.name
    assert_select "a[href=?]", category_path(@category2),text: @category2.name
  end
end
