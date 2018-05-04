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

end
