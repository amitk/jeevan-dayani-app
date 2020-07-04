class Api::V1::TrialConfigurationsController < ApplicationController
  before_action :find_trial_configuration, only: [:show, :update, :destroy]

  def index
    @trial_configurations = TrialConfiguration.all
    render json: { data: @trial_configurations }, status: :ok
  end

  def show
    render json: { data: @trial_configurations }
  end

  def create
    trial_configuration = TrialConfiguration.new(permit_params)
    if trial_configuration.save
      render json: { data: trial_configuration, message: I18n.t('create.success', model: "Trial Configuration") }, status: :ok
    else
      render json: {  error: I18n.t('create.error', model: "Trial Configuration"), message: trial_configuration.errors.messages },
        status: :unprocessable_entity
    end
  end

  def update
    if @trial_configuration.update(permit_params)
      render json: { data: @trial_configuration, message: I18n.t('update.success', model: "Trial Configuration") }, status: :ok
    else
      render josn: { error: I18n.t('update.error', model: "Trial Configuration")}, message: @trial_configuration.errors.messages,
        status: :unprocessable_entity
    end
  end

  def destroy
    if @trial_configuration && @trial_configuration.destroy
      render json: { message: I18n.t('delete.success', model: "Trial Configuration") }
    else
      render json: { message: I18n.t('delete.error', model: "Trial Configuration") }
    end
  end

  private

  def permit_params
    params.require(:trial_configuration).permit(:name, :drug_id, :doctor_id, :clinic_id)
  end

  def find_trial_configuration
    @trial_configuration = TrialConfiguration.find(params[:id])
  end
end
