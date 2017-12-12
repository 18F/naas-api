# app/controllers/notifications_controller.rb
class NotificationsController < ApplicationController
  before_action :set_notifications, only: [:show, :update, :destroy]

  # GET /notificationss
  def index
    @agencies = Notification.all
    json_response(@agencies)
  end

  # POST /notificationss
  def create
    @notifications = Notification.create!(notifications_params)
    json_response(@notifications, :created)
  end

  # GET /agencies/:id
  def show
    json_response(@notifications)
  end

  # PUT /agencies/:id
  def update
    @notifications.update(notifications_params)
    head :no_content
  end

  # DELETE /notificationss/:id
  def destroy
    @notifications.destroy
    head :no_content
  end

  private

  def notifications_params
    # whitelist params
    params.permit(:name, :created_by)
  end

  def set_notifications
    @notifications = Notification.find(params[:id])
  end
end