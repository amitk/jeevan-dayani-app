require 'acceptance_helper'

resource "feedbacks" do
  explanation "feedback resources"
  before(:each) do
    @trial = create :trial
    @feedback = create :feedback
  end

  header "Content-Type", "application/json"

  get '/api/v1/trials/:trial_id/feedbacks/:id' do
    let(:trial_id) { @trial.id }
    let(:id) { @feedback.id }

    with_options scope: :feedback do
      response_field :state, "Status of the feedback"
      response_field :trial, "Trial feedback belongs to"
      response_field :patient, "Patient giving the feedback"
    end

    example_request "Get a particular feedback in response" do
      expect(status).to eq(200)
    end
  end

  post '/api/v1/trials/:trial_id/feedbacks' do
    with_options scope: :feedback do
      parameter :state, "Stateof the feedback"
      parameter :trial, "Trial feedback belongs to"
      parameter :patient, "Patient giving the feedback"
    end
    let(:trial_id) { @feedback.trial.id }
    let(:params) {
      {
        feedback: {
          state: "happy",
          trial_id: trial_id,
          patient_id: @feedback.patient.id
        }
      }
    }

    example "successfully create a feedback" do
      do_request(params)
      expect(status).to eq(200)
    end
  end

  patch '/api/v1/trials/:trial_id/feedbacks/:id' do
    with_options scope: :feedback do
      parameter :state, "State of the feedback"
      parameter :trial, "Trial feedback belongs to"
      parameter :patient, "Patient giving the feedback"
    end
    let(:trial_id) { @feedback.trial.id }
    let(:id) { @feedback.id }
    let(:params) {
      {
        feedback: {
          state: "happy",
          trial_id: @trial.id,
          patient_id: @feedback.patient.id
        }
      }
    }

    example "updated a feedback" do
      do_request(params)
      expect(status).to eq(200)
    end
  end

  delete '/api/v1/trials/:trial_id/feedbacks/:id' do
    let(:trial_id) { @feedback.trial.id }
    let(:id) { @feedback.id }
    example "Delete a feedback" do
      do_request(params)
      expect(status).to eq(200)
    end
  end
end
