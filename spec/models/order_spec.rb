require 'rails_helper'

RSpec.describe OrderForm, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item, user: @user)
    @order_form = FactoryBot.build(:order_form, user_id: @user.id, item_id: @item.id)
  end

  describe '商品購入機能' do
    context '購入できる場合' do
      it 'すべての情報が正しく入力されていると購入できる' do
        expect(@order_form).to be_valid
      end
    end

    context '購入できない場合' do
      it '郵便番号が空では購入できない' do
        @order_form.postal_code = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Postal code はハイフンを含む7桁で入力してください')
      end

      it '郵便番号にハイフンが含まれていないと購入できない' do
        @order_form.postal_code = '1234567'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Postal code はハイフンを含む7桁で入力してください')
      end

      it '都道府県が選択されていないと購入できない' do
        @order_form.prefecture_id = 0
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Prefecture を選択してください')
      end

      it '市区町村が空では購入できない' do
        @order_form.city = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("City can't be blank")
      end

      it '番地が空では購入できない' do
        @order_form.address_line = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Address line can't be blank")
      end

      it '電話番号が空では購入できない' do
        @order_form.phone_number = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号が10桁未満では購入できない' do
        @order_form.phone_number = '090123'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Phone number は10桁または11桁の数字で入力してください')
      end

      it '電話番号が12桁以上では購入できない' do
        @order_form.phone_number = '090123456789'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Phone number は10桁または11桁の数字で入力してください')
      end

      it 'トークンが空では購入できない' do
        @order_form.token = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end