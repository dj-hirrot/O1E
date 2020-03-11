require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'username', email: 'user@mail.com')
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "     "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = 'a' * 16
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = 'a' * 247 + '@mail.com'
    assert_not @user.valid?
  end

  test "email validation should accept valid address" do
    valid_addresses = %w[
      user@mail.com
      USER@mail.COM
      A_US-ER@mail.mail.org
      first.last@mail.jp
      hiroto+naoki@mail.cn
    ]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[
      user@mail,com
      user_at_mail.org
      user.name@mail.
      user@hiroto_naoki.com
      user@hiroto+naoki.com
      user@mail..com
    ]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email should be uique" do
    dup_user = @user.dup
    dup_user.email = @user.email.upcase
    @user.save
    assert_not dup_user.valid?
  end

  test "email should be saved as lower-case" do
    mixed_case_email = "User@MaIl.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
end
