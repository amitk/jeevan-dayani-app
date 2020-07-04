class Api::V1::PharmaCompaniesController < ApplicationController
  before_action :load_pharma_company, only: [:show, :update]

  def index
    @companies = PharmaCompany.all
    render json: { data: @companies }, status: :ok
  end

  def show
    render json: { data: @pharma_company }, status: :ok
  end

  def create
    pharma_company = PharmaCompany.create(permit_params)
    render json: { data: pharma_company, message: "successfully created" }, status: :ok
  end

  def update
    @pharma_company.update(permit_params)
    render json: { data: @pharma_company }, status: :ok
  end

  private

  def permit_params
    params.require(:pharma_company).permit(:name)
  end

  def load_pharma_company
    @pharma_company = PharmaCompany.find(params[:id])
  end
end
