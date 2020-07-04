class Api::V1::ClinicsController < ApplicationController
  before_action :find_clinic, only: [:show, :update, :destroy]

  def index
    @clinics = Clinic.all
    render json: { data: @clinics }, status: :ok
  end

  def show
    render json: { data: @clinic }
  end

  def create
    clinic = Clinic.new(permit_params)
    if clinic.save
      render json: { data: clinic, message: I18n.t('create.success', model: "Clinic") }, status: :ok
    else
      render json: {  error: I18n.t('create.error', model: "Clinic"), message: clinic.errors.messages },
        status: :unprocessable_entity
    end
  end

  def update
    if @clinic.update(permit_params)
      render json: { data: @clinic, message: I18n.t('update.success', model: "Clinic") }, status: :ok
    else
      render josn: { error: I18n.t('update.error', model: "Clinic")}, message: @clinic.error_messages,
        status: :unprocessable_entity
    end
  end

  def destroy
    if @clinic && @clinic.destroy
      render json: { message: I18n.t('delete.success', model: "clinic") }
    else
      render json: { message: I18n.t('delete.error', model: "clinic") }
    end
  end

  private

  def permit_params
    params.require(:clinic).permit(:name, :country, :state, :city, :doctor_id)
  end

  def find_clinic
    @clinic = Clinic.find(params[:id])
  end
end
