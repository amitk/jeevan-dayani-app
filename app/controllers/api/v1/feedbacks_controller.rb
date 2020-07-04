class Api::V1::FeedbacksController < ApplicationController
  before_action :find_trial, only: [:create]
  before_action :find_feedback, only: [:show, :update, :destroy]

  def index
  end

  def show
    render json: { data: @feedback }
  end

  def create
    feedback = @trial.feedbacks.new(permit_params)
    if feedback.save
      render json: { data: feedback, message: I18n.t('create.success', model: "Feedback") }, status: :ok
    else
      render json: {  error: I18n.t('create.error', model: "feedback"), message: feedback.errors.messages },
        status: :unprocessable_entity
    end
  end

  def update
    if @feedback.update(permit_params)
      render json: { data: @feedback, message: I18n.t('update.success', model: "Feedback") }, status: :ok
    else
      render josn: { error: I18n.t('update.error', model: "feedback")}, message: @feedback.error_messages,
        status: :unprocessable_entity
    end
  end

  def destroy
    if @feedback && @feedback.destroy
      render json: { message: I18n.t('delete.success', model: "Feedback") }
    else
      render json: { message: I18n.t('delete.error', model: "feedback") }
    end
  end

  private

  def permit_params
    params.require(:feedback).permit(:state, :patient_id, :trial_id)
  end

  def find_feedback
    @feedback = Feedback.find(params[:id])
  end

  def find_trial
    @trial = Trial.find(params[:trial_id])
  end

end
