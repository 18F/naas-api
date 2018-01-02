# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy, :notifications]

  # GET /Users
  def index
    @users = User.all
    json_response(@users)
  end

  # POST /Users
  def create
    @user = User.create!(user_params)
    json_response(@user, :created)
  end

  # GET /users/:id
  def show
    json_response(@user)
  end

  # GET /users/:id/notifications
  # Supports notification signup, as this is a way to display notifications signed up for
  def notifications
    #@user = User.find(params[:id])
    json_response(@user.notifications)
  end

  # PUT /users/:id
  def update
    @user.update(user_params)
    head :no_content
  end

  # DELETE /Users/:id
  def destroy
    @user.destroy
    head :no_content
  end

  private

  def user_params
    # whitelist params
    params.permit(:email, :last_name, :first_name, :middle_name, :phone)
  end

  def set_user
    puts('hellooooooo')
    @user = User.find(params[:id])
  end


end