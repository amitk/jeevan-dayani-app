require 'acceptance_helper'

resource "Trial Configurations" do
  explanation "Trial configuration resources"

  header "Content-Type", "application/json"

  get '/api/v1/trial_configurations' do
    example_request "Get all trial configurations" do
      expect(status).to eq(200)
    end
  end

  get '/api/v1/trial_configurations/:id' do
    let(:trial_configuration) { create :trial_configuration }
    let(:id) { trial_configuration.id }

    example_request "Get a particular trial configurations" do
      expect(status).to eq(200)
    end
  end

  post '/api/v1/trial_configurations' do
    let(:drug) { create :drug }
    let(:clinic) { create :clinic }
    let(:doctor) { create :doctor }
    with_options scope: :trial_configurations do
      parameter :name, "Name of the trial configurations", required: :true
    end
    let(:params) {
      {
        trial_configuration: {
          name: "trialConfiguration",
          drug_id: drug.id,
          clinic_id: clinic.id,
          doctor_id: doctor.id,
        }
      }
    }

    example "Create a trial configuration" do
      do_request(params)
      expect(status).to eq(200)
    end
  end

  patch '/api/v1/trial_configurations/:id' do
    with_options scope: :clinic do
      parameter :name, "Name of the clinic", required: :true
      parameter :drug, "Drug name", required: :true
      parameter :clinic, "Clinic name", required: :true
      parameter :doctor, "Doctor name", required: :true
    end
    let(:trial_configuration) { create :trial_configuration }
    let(:id) { trial_configuration.id }
    let(:drug) { create :drug }
    let(:clinic) { create :clinic }
    let(:doctor) { create :doctor }
    let(:params) {
      {
        trial_configuration: {
          name: "trialConfiguration2",
          drug_id: drug.id,
          clinic_id: clinic.id,
          doctor_id: doctor.id,
        }
      }
    }

    example "updated a trial configuration" do
      do_request(params)
      expect(status).to eq(200)
    end
  end

  delete '/api/v1/trial_configurations/:id' do
    let(:trial_configuration) { create :trial_configuration }
    let(:id) { trial_configuration.id }
    example_request "Delete a trial configuration" do
      expect(status).to eq(200)
    end
  end
end
