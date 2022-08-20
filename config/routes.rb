Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  namespace :admin do
    get '' => 'homes#top'
    resources :items, except: [:destroy]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end

  scope module: :public do
    root 'homes#top'
    get 'about' => 'homes#about'
    resources :items, only: [:index, :show]
    resource :customers, only: [:show, :edit, :update] do
      get '/confirm' => 'customers#confirm'
      patch '/deleted' => 'customers#deleted'
    end

    delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :cart_items, only: [:index, :update, :create, :destroy]

    post 'orders/confirm' => 'orders#confirm'
    get "orders/confirm" => "orders#new"
    get 'orders/complete' => 'orders#complete'
    resources :orders, only: [:new, :create, :index, :show]

    resources :addresses, except: [:new, :show]
  end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
