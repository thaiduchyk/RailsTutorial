require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name:'Taras', email:'thaiduchyk@gmail.com')
  end

  test 'user should be valid' do
    assert @user.valid?
  end

  test 'name should not be blank' do
    @user.name = '      '
    assert_not @user.valid?
  end

  test 'email should not be blank' do
    @user.email = '      '
    assert_not @user.valid?
  end

  test 'name length should be less than 50 chars' do
    @user.name = 'a' * 51
    assert_not @user.valid?
  end

  test 'email length should be less than 255 chars' do
    @user.email = 'a' * 244 + '@example.com'
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
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


  test 'email should be unique' do
    @user.save
    @user1 = @user.dup
    @user1.email = @user.email.upcase
    assert_not @user1.valid?
  end

end
