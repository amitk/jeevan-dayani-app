class Api::V1::TrialsController < ApplicationController
  before_action :find_trial, only: [:show, :update, :destroy]

  def index
    @trials = Trial.all
    render json: { data: @trials }, status: :ok
  end

  def show
    render json: { data: @trial }
  end

  def create
    trial = Trial.new(permit_params)
    if trial.save
      render json: { data: trial, message: I18n.t('create.success', model: "Trial") }, status: :ok
    else
      render json: {  error: I18n.t('create.error', model: "Trial"), message: trial.errors.messages },
        status: :unprocessable_entity
    end
  end

  def update
    if @trial.update(permit_params)
      render json: { data: @trial, message: I18n.t('update.success', model: "Trial") }, status: :ok
    else
      render josn: { error: I18n.t('update.error', model: "Trial")}, message: @trial.error_messages,
        status: :unprocessable_entity
    end
  end

  def destroy
    if @trial && @trial.destroy
      render json: { message: I18n.t('delete.success', model: "trial") }
    else
      render json: { message: I18n.t('delete.error', model: "trial") }
    end
  end

  private

  def permit_params
    params.require(:trial).permit( :name, :age, :sex, :trial_id)
  end

  def find_trial
    @trial = Trial.find(params[:id])
  end
end
