Rails.application.routes.draw do

  # get 'users/index'

  devise_for :users, :controllers => {
    # :confirmations => 'users/confirmations',
    # :registrations => 'users/registrations',
    
    # :sessions => 'users/sessions',
    :passwords => 'users/passwords'
  }
  # resources :password_resets,     only: [:new, :create, :edit, :update]
  #  devise_for :users, :controllers => {
  #   :registrations => 'users/registrations',
  #   :sessions => 'users/sessions'   
  # } 

  get "users/holiday" => "users#holiday"
  get "users/week_holiday_change" => "users#week_holiday_change"

  resources :users do
    resources :remaining_holiday, only:  [:new, :create, :edit, :update], shallow: true
    resources :notification, only:  [:create, :show, :destroy], shallow: true
  end
 
  root to: "holidays#index"

  resources :group do
    resources :group_user, only:  [:show, :create, :destroy]
  end

  resources :holidays do
    resources :comments, only: [:create] 
    post 'agreement', to: 'request#agreement'
    post 'rejected', to: 'request#rejected'
  end

  resources :week_holiday_changes do
    post 'agreement', to: 'week_h_checks#agreement'
    post 'rejected', to: 'week_h_checks#rejected'
  end
end
