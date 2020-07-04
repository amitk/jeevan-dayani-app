require 'acceptance_helper'

resource "Doctors" do
  explanation "Doctor resources"
  # before(:each) do
  #   @pharma_company = create :pharma_company
  #   @drug = create :drug
  # end

  header "Content-Type", "application/json"

  get '/api/v1/doctors' do
    example_request "Get all doctors" do
      expect(status).to eq(200)
    end
  end

  get '/api/v1/doctors/:id' do
    let(:doctor) { create :doctor }
    let(:id) { doctor.id }

    with_options scope: :doctor do
      response_field :name, "Name of the doctor"
      response_field :specialization, "Doctor specialization"
    end

    example_request "Get a particular doctor" do
      expect(status).to eq(200)
    end
  end

  post '/api/v1/doctors' do
    with_options scope: :doctor do
      response_field :name, "Name of the doctor"
      response_field :specialization, "Doctor specialization"
    end

    let(:params) {
      {
        doctor: {
          name: "doctor1",
          specialization: "Heart"
        }
      }
    }

    example "Create a doctor" do
      do_request(params)
      expect(status).to eq(200)
    end
  end

  patch '/api/v1/doctors/:id' do
    with_options scope: :doctor do
      parameter :name, "Name of the doctor", required: :true
      parameter :specialization, "Doctor's specialization", required: :true
    end
    let(:doctor) { create :doctor }
    let(:id) { doctor.id }
    let(:params) {
      {
        doctor: {
          name: "doctor1",
          specialization: "Heart",
        }
      }
    }

    example "updated a doctor" do
      do_request(params)
      expect(status).to eq(200)
    end
  end

  delete '/api/v1/doctors/:id' do
    let(:doctor) { create :doctor }
    let(:id) { doctor.id }
    example_request "Delete a doctor" do
      expect(status).to eq(200)
    end
  end
end
