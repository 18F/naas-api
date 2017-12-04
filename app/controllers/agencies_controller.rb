# app/controllers/Agencys_controller.rb
class AgenciesController < ApplicationController
  before_action :set_agency, only: [:show, :update, :destroy]

  # GET /Agencys
  def index
    @agencies = Agency.all
    json_response(@agencies)
  end

  # POST /Agencys
  def create
    @agency = Agency.create!(agency_params)
    json_response(@agency, :created)
  end

  # GET /agencies/:id
  def show
    json_response(@agency)
  end

  # PUT /agencies/:id
  def update
    @agency.update(agency_params)
    head :no_content
  end

  # DELETE /Agencys/:id
  def destroy
    @agency.destroy
    head :no_content
  end

  private

  def agency_params
    # whitelist params
    params.permit(:name, :created_by)
  end

  def set_agency
    @agency = Agency.find(params[:id])
  end
end