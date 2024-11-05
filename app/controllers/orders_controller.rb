class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :redirect_if_seller_or_sold_out, only: [:index, :create]

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @order_form = OrderForm.new
  end

  def create
    @order_form = OrderForm.new(order_params)
    if @order_form.valid?
      pay_item
      @order_form.save
      @item.update(sold_out: true)
      redirect_to root_path, notice: '購入が完了しました。'
    else
      flash.now[:alert] = 'カード情報または配送情報に誤りがあります。'
      render :index
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def redirect_if_seller_or_sold_out
    redirect_to root_path if current_user.id == @item.user_id || @item.sold_out?
  end

  def order_params
    params.require(:order_form).permit(:postal_code, :prefecture_id, :city, :address_line, :building, :phone_number)
          .merge(token: params[:token], user_id: current_user.id, item_id: @item.id)
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end