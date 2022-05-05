Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }


  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    root to: "recipes#index"
    get "customers/unsubscribe"
    patch "customers/withdraw"
    resources :customers, only: [:edit, :update]
  end
end
