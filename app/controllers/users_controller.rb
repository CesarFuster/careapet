class UsersController < ApplicationController

  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @users = User.all
    @caregivers = User.where(caregiver: true).where.not(latitude: nil, longitude: nil)
    @markers = @caregivers.map do |user|
      {
        lat: user.latitude,
        lng: user.longitude#,
      }
    end


  end

  def show
    @user = User.find(params[:id])
    @task = Task.new
    @task = @user.task
    @review = Review.new
    @reviews = @user.reviews
    @pet = Pet.new
    @pets = @user.pets
    @service = Service.new
    @services = @user.services

    @marker =
      [{
        lat: @user.latitude,
        lng: @user.longitude
      }]
  end

end
