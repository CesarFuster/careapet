class UsersController < ApplicationController

  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if params[:address].present?
      @caregivers = User.where(caregiver: true).where.not(latitude: nil, longitude: nil).near(params[:address], 5)
    else
      @users = User.all
      @caregivers = User.where(caregiver: true).where.not(latitude: nil, longitude: nil)
    end

    @markers = @caregivers.map do |user|
      {
        lat: user.latitude,
        lng: user.longitude#,
      }
    end

  end

  def show
    @user = User.find(params[:id])
    @review = Review.new
    @reviews = @user.reviews
    @avg_review = @user.reviews.average(:rating)

    @order = Order.new
    @orders = @user.orders
    @pet = Pet.new
    @pets = @user.pets
    @user_task = UserTask.new
    @user_tasks = @user.user_tasks
    @service = Service.new
    @buyer_services = @user.buyer_services
    @caregiver_services = @user.caregiver_services

    @marker =
      [{
        lat: @user.latitude,
        lng: @user.longitude
      }]
  end

  def upvote
    if @user == current_user
      flash[:alert] = "Não autorizado!"
      redirect_to user_path(@user)
    else
      @user = User.find(params[:id])
      if current_user.voted_for? @user
        @user.unvote_by current_user
        redirect_to user_path(@user)
      else
        @user.upvote_by current_user
        redirect_to user_path(@user)
      end
    end
  end

end
