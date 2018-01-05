# app/controllers/user_subscriptions_controller.rb
class UserSubscriptionsController < ApplicationController
  before_action :set_notification
  before_action :set_user
  before_action :set_notification_user_subscription, only: [:show, :update, :destroy]

  # GET /notifications/:notification_id/user_subscriptions
  # GET /users/:user_id/user_subscriptions
  def index

    if @notification
        json_response(@notification.user_subscriptions)
    end
    if request.path_parameters.has_key?(:user_id)
        json_response(@user.user_subscriptions)
    end
  end

  # GET /notifications/:notification_id/user_subscriptions/:id
  # GET /users/:user_id/user_subscriptions/:id
  def show
    json_response(@user_subscription)
  end

  # POST /notifications/:notification_id/user_subscriptions
  def create
    @notification.user_subscriptions.create!(user_subscription_params)
    #@user = User.find(params[:user_id])
    #@user.user_subscriptions.create!(user_subscription_params)
    json_response(@user_subscription, :created)
  end

  # PUT /notifications/:notification_id/user_subscriptions/:id
  def update
    @user_subscription.update(user_subscription_params)
    head :no_content
  end

  # DELETE /notifications/:notification_id/user_subscriptions/:id
  def destroy
    @user_subscription.destroy
    head :no_content
  end

  private

  def user_subscription_params
    params.permit(:name, :user_id, :notification_id)
  end

  def notification_params
    params.permit(:name, :notification_id, :user_id)
  end

  def set_notification
    if request.path_parameters.has_key?(:notification_id)
      @notification = Notification.find(params[:notification_id])
    end
  end

  def set_user
    if request.path_parameters.has_key?(:user_id)
      @user = User.find(params[:user_id])
    end
  end

  def set_notification_user_subscription
    @user_subscription = @notification.user_subscriptions.find_by!(id: params[:id]) if @notification
  end
end