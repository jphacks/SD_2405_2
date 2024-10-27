Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users, only: [:create, :index]
  resources :items, only: [:create, :index] do
    collection do
      patch :update_status  # PATCHリクエストを使用してステータスを更新
      post  :upsert  # 作成と更新を同時に行う
    end
  end
  resources :categories, only: [:index]
end
