require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザーバリデーションのテスト' do
    subject { build(:user) }

    context 'ユーザーの登録が有効な場合' do
      it '全ての項目が正しく入力されていれば登録できる' do
        expect(subject).to be_valid
      end
    end

    context 'バリデーションが発生する場合' do
      it 'ニックネームが空では登録できない' do
        subject.nickname = nil
        expect(subject).to_not be_valid
      end

      it 'メールアドレスが空では登録できない' do
        subject.email = nil
        expect(subject).to_not be_valid
      end

      it 'パスワードが空では登録できない' do
        subject.password = nil
        expect(subject).to_not be_valid
      end

      it '生年月日が空では登録できない' do
        subject.birthday = nil
        expect(subject).to_not be_valid
      end

      it '苗字が全角以外だと登録できない' do
        subject.last_name = 'Tomato'
        expect(subject).to_not be_valid
      end

      it '名前が全角以外だと登録できない' do
        subject.first_name = 'Daisuki'
        expect(subject).to_not be_valid
      end

      it '苗字のフリガナがカタカナ以外だと登録できない' do
        subject.last_name_kana = 'とまと'
        expect(subject).to_not be_valid
      end

      it '名前のフリガナがカタカナ以外だと登録できない' do
        subject.first_name_kana = 'だいすき'
        expect(subject).to_not be_valid
      end
    end
  end
end