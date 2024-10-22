require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    let(:user) { build(:user) }

    it '有効なユーザー' do
      expect(user).to be_valid
    end

    it 'ニックネームが必須' do
      user.nickname = nil
      expect(user).to_not be_valid
    end

    it 'メールアドレスが必須' do
      user.email = nil
      expect(user).to_not be_valid
    end

    it 'パスワードが必須' do
      user.password = nil
      expect(user).to_not be_valid
    end

    it '生年月日が必須' do
      user.birthday = nil
      expect(user).to_not be_valid
    end
  end
end
