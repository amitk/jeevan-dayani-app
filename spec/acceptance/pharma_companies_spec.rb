require 'acceptance_helper'

resource 'pharma_companies' do

  header 'Content-Type', 'application/json'

  get '/api/v1/pharma_companies' do
    example_request "Get all the pharma companies in the response" do
      expect(status).to eq(200)
    end
  end

  get '/api/v1/pharma_companies/:id' do
    let(:pharma_company) { create :pharma_company }
    let(:id) { pharma_company.id }
    example "Get a particular pharma company" do
      do_request
      expect(status).to eq(200)
    end
  end

  post '/api/v1/pharma_companies' do
    with_options scope: :pharma_company do
      parameter :name, "Name of the pharma company", required: :true
    end

    let!(:params) {
      {
        pharma_company: {
          name: "pharma_company1"
        }
      }
    }
    example "create a pharma company" do
      do_request(params)
      expect(status).to eq(200)
    end
  end

  patch '/api/v1/pharma_companies/:id' do
    with_options scope: :pharma_company do
      parameter :name, "Name of the pharma company"
    end
    let(:pharma_company) { create :pharma_company }
    let(:id) { pharma_company.id }
    let(:params) {
      {
        pharma_company: {
          name: "pharma_company1"
        }
      }
    }
    example "update a pharma company" do
      do_request(params)
      expect(status).to eq(200)
    end
  end
end
