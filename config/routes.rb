Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [] do
    resources :students, only: [:index, :edit, :new, :create, :update, :destroy]
  end

  get "up" => "rails/health#show", as: :rails_health_check

  get "service-worker" => "pwa#service_worker", as: :pwa_service_worker
  get "manifest.json" => "pwa#manifest", as: :pwa_manifest

  match "*unmatched", to: "application#render_404", via: :all, constraints: lambda { |req|
    !req.path.start_with?("/students") && !req.path.start_with?("/manifest", "/service-worker")
  }

  devise_scope :user do
    root "devise/sessions#new"
  end
end
