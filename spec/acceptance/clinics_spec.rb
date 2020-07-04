require 'acceptance_helper'

resource "Clinics" do
  explanation "Clinic resources"
  # before(:each) do
  #   @pharma_company = create :pharma_company
  #   @drug = create :drug
  # end

  header "Content-Type", "application/json"

  get '/api/v1/clinics' do
    example_request "Get all clinics" do
      expect(status).to eq(200)
    end
  end

  get '/api/v1/clinics/:id' do
    let(:clinic) { create :clinic }
    let(:id) { clinic.id }

    with_options scope: :clinic do
      response_field :name, "Name of the clinic"
      response_field :country, "Country name"
      response_field :state, "State name"
      response_field :city, "City name"
    end

    example_request "Get a particular clinic" do
      expect(status).to eq(200)
    end
  end

  post '/api/v1/clinics' do
    with_options scope: :clinic do
      parameter :name, "Name of the clinic", required: :true
      parameter :country, "Country name", required: :true
      parameter :state, "State name", required: :true
      parameter :city, "City name", required: :true
    end
    let(:params) {
      {
        clinic: {
          name: "clinic1",
          country: "India",
          state: "Maharashtra",
          city: "Pune",
        }
      }
    }

    example "Create a clinic" do
      do_request(params)
      expect(status).to eq(200)
    end
  end

  patch '/api/v1/clinics/:id' do
    with_options scope: :clinic do
      parameter :name, "Name of the clinic", required: :true
      parameter :country, "Country name", required: :true
      parameter :state, "State name", required: :true
      parameter :city, "City name", required: :true
    end
    let(:clinic) { create :clinic }
    let(:id) { clinic.id }
    let(:params) {
      {
        clinic: {
          name: "clinic1",
          country: "India",
          state: "Maharashtra",
          city: "Pune",
        }
      }
    }

    example "updated a clinic" do
      do_request(params)
      expect(status).to eq(200)
    end
  end

  delete '/api/v1/clinics/:id' do
    let(:clinic) { create :clinic }
    let(:id) { clinic.id }
    example_request "Delete a clinic" do
      expect(status).to eq(200)
    end
  end
end
