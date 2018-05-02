class ServicesController < ApplicationController

  before_action :set_user, only: [:new, :create]
  before_action :set_service, only: [:show, :toggle, :toggle_pay_authorized]

  def index
    @services = Service.all
  end

  def show
  end

  def toggle
    @service.toggle(:confirmed)
    @service.save
    ServiceMailer.pay_service_buyer(@service).deliver_now
    ServiceMailer.pay_service_caregiver(@service).deliver_now
    redirect_to service_path(@service)
  end

  def toggle_pay_authorized
    @service.toggle(:pay_authorized)
    @service.save
    ServiceMailer.paid_service_caregiver(@service).deliver_now
    redirect_to service_path(@service)
  end

  def new
    @service = Service.new
  end

  def create
    @service = Service.new(service_params)
    @service.buyer = current_user
    @service.caregiver = @user
      if @service.save!
        ServiceMailer.new_service_buyer(@service).deliver_now
        ServiceMailer.new_service_caregiver(@service).deliver_now
        flash[:alert] = "Serviço solicitado!"
        redirect_to service_path(@service)
      else
        render :new
      end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_service
    @service = Service.find(params[:id])
  end

  def service_params
    params.require(:service).permit(:start_date, :end_date, :buyer_id, :caregiver_id, :confirmed, :pay_authorized)
  end

end
