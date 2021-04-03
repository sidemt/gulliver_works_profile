# frozen_string_literal: true
Rails.application.routes.draw do
  namespace :auth do
    namespace :v1 do
      post :sign_in, to: 'auth#sign_in'
      post :sign_up, to: 'auth#sign_up'
    end
  end

  namespace :enterprise_auth do
    namespace :v1 do
      post :sign_in, to: 'auth#sign_in'
      post :sign_up, to: 'auth#sign_up'
    end
  end

  namespace :v1 do
    resources :accounts, only: %i[index show destroy] do
      get :profile, to: 'account_profile#show'
      post :profile, to: 'account_profile#create'
      patch :profile, to: 'account_profile#update'
    end
    resources :occupation_main_categories, only: :index
    resources :industry_categories, only: :index
    resources :prefectures, only: :index
    resources :employment_statuses, only: :index
  end

  namespace :enterprise do
    namespace :v1 do
      resources :employees, only: %i[show destroy] do
        get :profile, to: 'employee_profile#show'
        post :profile, to: 'employee_profile#create'
        patch :profile, to: 'employee_profile#update'
      end
      resources :companies
      resources :occupation_main_categories, only: :index
      resources :industry_categories, only: :index
      resources :prefectures, only: :index
      resources :employment_statuses, only: :index
    end
  end
end
