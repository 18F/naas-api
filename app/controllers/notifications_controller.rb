# app/controllers/notifications_controller.rb
class NotificationsController < ApplicationController

  before_action :set_notifications, only: [:show, :update, :destroy, :users, :send_group_notification]
  include SmsTool

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

  def users
    json_response(@notifications.users)
  end

  def send_group_notification
    users = @notifications.users
    body = params[:body] || @notifications.body

    users.each do |user|
      SmsTool.send_sms(user.phone, body, 'naas-api' )
    end

    users.each do |user|
      user.notification_events.create!(:body => body, :unread => true, :user_id => user.id )
    end

  end

  private

  def notifications_params
    # whitelist params
    params.permit(:name, :created_by, :body)
  end

  def set_notifications
    @notifications = Notification.find(params[:id])
  end
end