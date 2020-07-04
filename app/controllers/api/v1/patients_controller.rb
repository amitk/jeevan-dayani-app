class Api::V1::PatientsController < ApplicationController
  before_action :load_trial, only: [:index, :create]
  before_action :find_patient, only: [:show, :update, :destroy]

  def index
    @patients = @trial.patients.all
    render json: { data: @patients }, status: :ok
  end

  def show
    render json: { data: @patient }
  end

  def create
    patient = @trial.patients.new(permit_params)
    if patient.save
      render json: { data: patient, message: I18n.t('create.success', model: "Patient") }, status: :ok
    else
      render json: {  error: I18n.t('create.error', model: "Patient"), message: patient.errors.messages },
        status: :unprocessable_entity
    end
  end

  def update
    if @patient.update(permit_params)
      render json: { data: @patient, message: I18n.t('update.success', model: "Patient") }, status: :ok
    else
      render josn: { error: I18n.t('update.error', model: "Patient")}, message: @patient.error_messages,
        status: :unprocessable_entity
    end
  end

  def destroy
    if @patient && @patient.destroy
      render json: { message: I18n.t('delete.success', model: "Patient") }
    else
      render json: { message: I18n.t('delete.error', model: "Patient") }
    end
  end

  private

  def permit_params
    params.require(:patient).permit( :name, :age, :sex, :trial_id)
  end

  def find_patient
    @patient = Patient.find(params[:id])
  end

  def load_trial
    @trial = Trial.find(params[:trial_id])
  end
end
