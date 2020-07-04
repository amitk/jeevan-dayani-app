class Api::V1::DoctorsController < ApplicationController
  before_action :find_doctor, only: [:show, :update, :destroy]

  def index
    @doctors = Doctor.all
    render json: { data: @doctors }, status: :ok
  end

  def show
    render json: { data: @doctor }
  end

  def create
    doctor = Doctor.new(permit_params)
    if doctor.save
      render json: { data: doctor, message: I18n.t('create.success', model: "Doctor") }, status: :ok
    else
      render json: {  error: I18n.t('create.error', model: "Doctor"), message: doctor.errors.messages },
        status: :unprocessable_entity
    end
  end

  def update
    if @doctor.update(permit_params)
      render json: { data: @doctor, message: I18n.t('update.success', model: "doctor") }, status: :ok
    else
      render josn: { error: I18n.t('update.error', model: "doctor")}, message: @doctor.error_messages,
        status: :unprocessable_entity
    end
  end

  def destroy
    if @doctor && @doctor.destroy
      render json: { message: I18n.t('delete.success', model: "doctor") }
    else
      render json: { message: I18n.t('delete.error', model: "doctor") }
    end
  end

  private

  def permit_params
    params.require(:doctor).permit(:name, :specialization)
  end

  def find_doctor
    @doctor = Doctor.find(params[:id])
  end
end
