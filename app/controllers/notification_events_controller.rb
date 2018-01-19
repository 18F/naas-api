class NotificationEventsController < ApplicationController
  before_action :set_user
  before_action :set_notification_event, only: [:show, :update, :destroy]

  # GET /Notification_Events
  def index
    @notification_events = @user.notification_events
    json_response(@notification_events)
  end

  # POST /Notification_Events
  def create
    notification_event = @user.notification_events.create!(notification_event_params)
    json_response(notification_event, :created)
  end

  # GET /Notification_Events/:id
  def show
    json_response(@notification_event)
  end

  # PUT /Notification_Events/:id
  def update
    #had trouble implementing a simple boolean in rails, this works
    attributes = notification_event_params.clone
    unread = params[:unread] == "1"
    attributes[:unread] = unread
    attributes.delete(:notification_event)
    @notification_event.update!(attributes)
    head :no_content
  end

  # DELETE /Notification_Events/:id
  def destroy
    @notification_event.destroy
    head :no_content
  end

  private

  def notification_event_params
    # whitelist params
    params.permit(:body, :unread, :user_id, :id, :notification_event)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_notification_event
    @notification_event = @user.notification_events.find_by!(id: params[:id]) if @user

  end
end
