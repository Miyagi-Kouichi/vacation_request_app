Rails.application.routes.draw do

  devise_for :users, :controllers => {
    :passwords => 'users/passwords'
  }

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

  get "holidays/cancel_new" => "holidays#cancel_new"
  post "holidays/cancel_create" => "holidays#cancel_create"

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
