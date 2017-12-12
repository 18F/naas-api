# app/controllers/user_subscriptions_controller.rb
class UserSubscriptionsController < ApplicationController
  before_action :set_user_subscription
  before_action :set_notification_user_subscription, only: [:show, :update, :destroy]

  # GET /notifications/:notification_id/user_subscriptions
  def index
    json_response(@notification.user_subscriptions)
  end

  # GET /notifications/:notification_id/user_subscriptions/:id
  def show
    json_response(@user_subscription)
  end

  # POST /notifications/:notification_id/user_subscriptions
  def create
    @notification.user_subscriptions.create!(user_subscription_params)
    #@user.notifications.create!(notification_params)
    json_response(@user_subscription, :created)
  end

  # PUT /notifications/:notification_id/user_subscriptions/:id
  def update
    @user_subscription.update(user_subscription_params)
    head :no_content
  end

  # DELETE /notifications/:notification_id/user_subscriptions/:id
  def destroy
    @notification.destroy
    head :no_content
  end

  private

  def user_subscription_params
    params.permit(:name, :user_id)
  end

  def set_user_subscription
    @notification = Notification.find(params[:notification_id])
  end

  def set_notification_user_subscription
    @user_subscription = @notification.user_subscriptions.find_by!(id: params[:id]) if @notification
  end
end