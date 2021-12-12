Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  resources :email_campaigns, only: %i[index show create update destroy] do
    member do
      get :mails
      get :clients
      post :add_client
      delete :delete_client
      post :send_mails
    end
  end

  post 'sign_up', to: 'users#sign_up'
  post 'sign_in', to: 'users#sign_in'
end
