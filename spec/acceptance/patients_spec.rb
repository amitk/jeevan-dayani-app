require 'acceptance_helper'

resource "patients" do
  explanation "patient resources"
  before(:each) do
    @trial = create :trial
    @patient = create :patient
  end

  header "Content-Type", "application/json"

  get '/api/v1/trials/:trial_id/patients' do
    let(:trial_id) { @trial.id }
    example_request "Get list of all the patients in a trial" do
      expect(status).to eq(200)
    end
  end

  get '/api/v1/trials/:trial_id/patients/:id' do
    let(:trial_id) { @trial.id }
    let(:id) { @patient.id }

    with_options scope: :patient do
      response_field :name, "Name of the patient"
      response_field :age, "Age of the patient"
      response_field :sex, "Patient gender"
      response_field :trial, "Trial object"
    end

    example_request "Get a particular patient in response" do
      expect(status).to eq(200)
    end
  end

  post '/api/v1/trials/:trial_id/patients' do
    with_options scope: :patient do
      parameter :name, "Name of the patient", required: :true
      parameter :age, "Age of the patient", required: :true
      parameter :sex, "Patient gender"
    end
    let(:trial_id) { @trial.id }
    let(:params) {
      {
        patient: {
          name: "patient1",
          age: 23,
          sex: "M"
        }
      }
    }

    example "successfully create a patient" do
      do_request(params)
      expect(status).to eq(200)
    end
  end

  patch '/api/v1/trials/:trial_id/patients/:id' do
    with_options scope: :patient do
      parameter :name, "Name of the patient", required: :true
      parameter :age, "Age of the patient", required: :true
      parameter :sex, "Patient gender"
    end
    let(:trial_id) { @patient.trial.id }
    let(:id) { @patient.id }
    let(:params) {
      {
        patient: {
          name: "patient1",
          age: 23,
          sex: "M"
        }
      }
    }

    example "updated a patient" do
      do_request(params)
      expect(status).to eq(200)
    end
  end

  delete '/api/v1/trials/:trial_id/patients/:id' do
    let(:trial_id) { @patient.trial.id }
    let(:id) { @patient.id }
    example "Delete a patient" do
      do_request(params)
      expect(status).to eq(200)
    end
  end
end
