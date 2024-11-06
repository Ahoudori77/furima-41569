require 'rails_helper'

RSpec.describe PurchaseForm, type: :model do
before do
  @user = FactoryBot.create(:user)
  @item = FactoryBot.create(:item, user: @user)
  @purchase_form = FactoryBot.build(:purchase_form, user_id: @user.id, item_id: @item.id)
end

  describe '商品購入機能' do
    context '購入できる場合' do
      it 'すべての情報が正しく入力されていると購入できる' do
        expect(@purchase_form).to be_valid
      end

      it '建物名が空でも購入できる' do
        @purchase_form.building = ''
        expect(@purchase_form).to be_valid
      end
    end

    context '購入できない場合' do
      it '郵便番号が空では購入できない' do
        @purchase_form.postal_code = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include('Postal code はハイフンを含む7桁で入力してください')
      end

      it '郵便番号が「3桁-4桁」の形式でないと購入できない' do
        @purchase_form.postal_code = '1234567'
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include('Postal code はハイフンを含む7桁で入力してください')
      end

      it '都道府県が選択されていないと購入できない' do
        @purchase_form.prefecture_id = 0
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include('Prefecture を選択してください')
      end

      it '市区町村が空では購入できない' do
        @purchase_form.city = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("City can't be blank")
      end

      it '番地が空では購入できない' do
        @purchase_form.address_line = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Address line can't be blank")
      end

      it '電話番号が空では購入できない' do
        @purchase_form.phone_number = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号が10桁未満では購入できない' do
        @purchase_form.phone_number = '090123456'
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include('Phone number は10桁または11桁の数字で入力してください')
      end

      it '電話番号が12桁以上では購入できない' do
        @purchase_form.phone_number = '090123456789'
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include('Phone number は10桁または11桁の数字で入力してください')
      end

      it '電話番号に半角数字以外が含まれていると購入できない' do
        @purchase_form.phone_number = '090-1234-5678'
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include('Phone number は10桁または11桁の数字で入力してください')
      end

      it 'トークンが空では購入できない' do
        @purchase_form.token = nil
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Token を入力してください")
      end

      it 'user_idが空だと購入できない' do
        @purchase_form.user_id = nil
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("User can't be blank")
      end

      it 'item_idが空だと購入できない' do
        @purchase_form.item_id = nil
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end