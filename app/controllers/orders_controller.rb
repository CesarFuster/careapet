class OrdersController < ApplicationController

  def show
    @order = current_user.orders.where(state: 'paid').find(params[:id])
  end

  def create
    service = Service.find(params[:service_id])
    order  = Order.create!(service: service, amount: service.price, state: 'pending', user: current_user)

    redirect_to new_order_payment_path(order)
  end

end
