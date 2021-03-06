Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
    resources :categories, only: [:index, :create, :edit, :update, :destroy]
    resources :reviews, only: [:index, :destroy]
    resources :recipes, only: [:index, :show, :destroy]
    resources :searches, only: [:index]
  end


  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_scope :customer do
    post "customers/guest_sign_in", to: "public/customers#guest_sign_in"
  end

  scope module: :public do
    root to: "recipes#top"
    get "customers/unsubscribe"
    patch "customers/withdraw"
    get "favorites" => "favorites#index"
    get "reviews" => "reviews#index"
    get "search_tag" => "searches#search_tag"
    resources :customers, only: [:show, :edit, :update, :index] do
      resource :relationships, only: [:create, :destroy]
      get "follows" => "relationships#follows"
      get "followers" => "relationships#followers"
    end
    resources :recipes, only: [:new, :create, :show, :edit, :update, :destroy, :index] do
      resources :foods, only: [:new, :create, :destroy, :index]
      resources :procedures, only: [:new, :create, :destroy, :index]
      resources :reviews, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
    resources :searches, only: [:index]
    resources :view_counts, only: [:index]
    resources :notifications, only: [:index, :destroy]
    resources :contacts, only: [:new, :create, :index]
    resources :news, only: [:index]
  end
end
