require 'rails_helper'

RSpec.describe User, type: :model do
  # メール、パスワードがあれば有効な状態であること
  it "is valid with an email and password" do
    user = User.new(
      email: "test@test.com",
      password: "thisisatestcode"
    )
    expect(user).to be_valid
  end
  # メールアドレスがなければ無効な状態であること
  it "is invalid without an email address" do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end
  # 重複したメールアドレスなら無効な状態であること
  it "is invalid with a duplicate email address" do
    User.create(
      email: "test@test.com",
      password: "thisisatestcode"
    )
    user = User.new(
      email: "test@test.com",
      password: "thisisatestcode"
    )
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end
end
