Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :pharma_companies, only: [:index, :create, :show, :update] do
        resources :drugs
      end
      resources :clinics
      resources :doctors
      resources :trial_configurations
      resources :trials do
        resources :patients
        resources :feedbacks
      end
    end
  end
end
