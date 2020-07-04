class Api::V1::DrugsController < ApplicationController
  before_action :load_company, only: [:index, :create]
  before_action :load_drug, only: [:show, :update, :destroy]

  def index
    @drugs = @pharma_company.drugs.page params[:page]
    render json: { data: @drugs }, status: :ok
  end

  def show
    render json: { data: @drug }, status: :ok
  end

  def create
    drug = @pharma_company.drugs.new(permit_params)
    if drug.save
      render json: { data: drug, message: I18n.t('create.success', model: "Drug") }, status: :ok
    else
      render json: {  error: I18n.t('create.error', model: "Drug"), message: drug.errors.messages },
        status: :unprocessable_entity
    end
  end

  def update
    if @drug.update(permit_params)
      render json: { data: @drug, message: I18n.t('update.success', model: "Drug") }, status: :ok
    else
      render josn: { error: I18n.t('update.error', model: "Drug")}, message: @drug.error_messages,
        status: :unprocessable_entity
    end
  end

  def destroy
    if @drug && @drug.destroy
      render json: { message: I18n.t('delete.success', model: "Drug") }
    else
      render json: { message: I18n.t('delete.error', model: "Drug") }
    end
  end

  private

  def permit_params
    params.require(:drug).permit(:name, :target_ailment, :pharma_company_id, side_effects: [])
  end

  def load_company
    @pharma_company = PharmaCompany.find(params[:pharma_company_id])
  end

  def load_drug
    @drug = Drug.find(params[:id])
  end
end
