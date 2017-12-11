# app/controllers/notifications_controller.rb
class NotificationsController < ApplicationController
  before_action :set_agency
  before_action :set_user
  before_action :set_agency_notification, only: [:show, :update, :destroy]

  # GET /agencies/:agency_id/notifications
  def index
    json_response(@agency.notifications)
  end

  # GET /agencies/:agency_id/notifications/:id
  def show
    json_response(@notification)
  end

  # POST /agencies/:agency_id/notifications
  def create
    @agency.notifications.create!(notification_params)
    #@user.notifications.create!(notification_params)
    json_response(@agency, :created)
  end

  # PUT /agencies/:agency_id/notifications/:id
  def update
    @notification.update(notification_params)
    head :no_content
  end

  # DELETE /agencies/:agency_id/notifications:id
  def destroy
    @notification.destroy
    head :no_content
  end

  private

  def notification_params
    params.permit(:name, :user_id)
  end

  def set_agency
    @agency = Agency.find(params[:agency_id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_agency_notification
    @notification = @agency.notifications.find_by!(id: params[:id]) if @agency
  end
end