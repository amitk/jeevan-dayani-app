require 'acceptance_helper'

resource "Drugs" do
  explanation "Drug resources"
  before(:each) do
    @pharma_company = create :pharma_company
    @drug = create :drug
  end

  header "Content-Type", "application/json"

  get '/api/v1/pharma_companies/:pharma_company_id/drugs' do
    let(:pharma_company_id) { @pharma_company.id }
    example_request "Get list of all the drugs by a pharma company" do
      expect(status).to eq(200)
    end
  end

  get '/api/v1/pharma_companies/:pharma_company_id/drugs/:id' do
    let(:pharma_company_id) { @pharma_company.id }
    let(:id) { @drug.id }

    with_options scope: :drug do
      response_field :name, "Name of the drug"
      response_field :target_ailment, "Target ailment of the drug"
      response_field :side_effects, "Side effects of the drug use"
      response_field :pharma_company, "Pharam Company object"
    end

    example_request "Get a particular drug in response" do
      expect(status).to eq(200)
    end
  end

  post '/api/v1/pharma_companies/:pharma_company_id/drugs' do
    with_options scope: :drug do
      parameter :name, "Name of the drug", required: :true
      parameter :target_ailment, "Target Ailment to the drug", required: :true
      parameter :side_effects, "An array of side Effects of the drug"
    end
    let(:pharma_company_id) { @pharma_company.id }
    let(:params) {
      {
        drug: {
          name: "Drug1",
          target_ailment: "Heart",
          side_effects: ["loss of hearing", "hair loss"]
        }
      }
    }

    example "successfully create a drug" do
      do_request(params)
      expect(status).to eq(200)
    end
  end

  patch '/api/v1/pharma_companies/:pharma_company_id/drugs/:id' do
    with_options scope: :drug do
      parameter :name, "Name of the drug"
      parameter :target_ailment, "Target Ailment to the drug"
      parameter :side_effects, "An array of side Effects of the drug"
    end
    let(:pharma_company_id) { @drug.pharma_company.id }
    let(:id) { @drug.id }
    let(:params) {
      {
        drug: {
          name: "Drug3",
          target_ailment: "Heart",
          side_effects: ["loss of hearing", "hair loss"]
        }
      }
    }

    example "successfully updated a drug" do
      do_request(params)
      expect(status).to eq(200)
    end
  end

  delete '/api/v1/pharma_companies/:pharma_company_id/drugs/:id' do
    let(:pharma_company_id) { @drug.pharma_company.id }
    let(:id) { @drug.id }
    example "Delete a drug" do
      do_request(params)
      expect(status).to eq(200)
    end
  end
end
