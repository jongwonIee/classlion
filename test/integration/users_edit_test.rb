require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:woori)
  end

  test "수정 실패!" do
    get edit_user_path(@user)
    assert_template "users/edit"
    patch user_path(@user), params: { user: { nickname: "",
                                              email: "foo@invalid",
                                              password: "algktl1004",
                                              password_confirmation: "algktl1004" } }
    assert_template "users/edit"
  end
end
