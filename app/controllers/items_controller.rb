class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:edit, :update, :show, :destroy]
  before_action :redirect_unless_owner, only: [:edit, :update, :destroy]

  def index
    @items = Item.all.order('created_at DESC')
  end
  
  def new
    @item = Item.new
    load_dropdown_data
  end
  
  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
    
    if @item.save
      redirect_to root_path, notice: '商品が出品されました'
    else
      puts @item.errors.full_messages
      load_dropdown_data
      render :new, status: :unprocessable_entity
    end
  end
  
  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to @item, notice: 'Item was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @item.user_id == current_user.id
      if @item.destroy
        redirect_to root_path, notice: '商品を削除しました'
      else
        redirect_to item_path(@item), alert: '商品の削除に失敗しました'
      end
    else
      redirect_to root_path, alert: '権限がありません'
    end
  end

  private

  def set_item
    @item = Item.find_by(id: params[:id])
    if @item.nil?
      redirect_to root_path, alert: '指定された商品が見つかりません。'
    end
  end

  def redirect_unless_owner
    redirect_to root_path unless current_user && @item && @item.user_id == current_user.id
  end

  def item_params
    params.require(:item).permit(:name, :description, :image, :category_id, :condition_id, :shipping_fee_id, :prefecture_id, :delivery_time_id, :price)
  end

  def load_dropdown_data
    @categories = Category.all
    @conditions = Condition.all
    @shipping_fees = ShippingFee.all
    @prefectures = Prefecture.all
    @delivery_times = DeliveryTime.all
  end

end