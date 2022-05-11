Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :categories, only: [:index, :create, :edit, :update]
  end


  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_scope :customer do
    post "customers/guest_sign_in", to: "public/customers#guest_sign_in"
  end

  scope module: :public do
    root to: "recipes#index"
    get "customers/unsubscribe"
    patch "customers/withdraw"
    get "searches/search"
    get "favorites" => "favorites#index"
    resources :customers, only: [:show, :edit, :update]
    resources :recipes, only: [:new, :create, :show, :edit, :update, :destroy] do
      resources :foods, only: [:new, :create, :destroy]
      resources :procedures, only: [:new, :create, :destroy]
      resources :reviews, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
  end
end
