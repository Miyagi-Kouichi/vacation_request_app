Rails.application.routes.draw do
  # resources :week_h_checks
  # get 'users/index'
  devise_for :users

  get "users/holiday" => "users#holiday"
  get "users/week_holiday_change" => "users#week_holiday_change"

  resources :users do
    resources :remaining_holiday
    resources :notification, only:  [:create, :show, :destroy], shallow: true
  end
 
  root to: "group#index"

  resources :group do
    resources :group_user, only:  [:show, :create, :destroy]
    # get 'show', to: 'gorup_user#show'
    # post 'join', to: 'gorup#join'
    # delete 'leave', to: 'gorup#leave'
  end
  # get "group/group_user" => "group#group_user"

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
