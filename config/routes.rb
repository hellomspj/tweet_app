Rails.application.routes.draw do
  get "/" => "home#top"
  get "about" => "home#about"
  
  get "signup" => "users#new"
  # For link_to
  get "login" => "users#login_form"
  # For form_tag
  post "login" => "users#login"
  # sessionの値を変更する場合もpost
  post "logout" => "users#logout"

  get "posts/index" => "posts#index"
  get "posts/new" => "posts#new"
  post "posts/create" => "posts#create"

  # idごとの投稿詳細ページ
  get "posts/:id" => "posts#show"
  # 編集機能
  get "posts/:id/edit" => "posts#edit"
  # 更新機能(DBに変更を加えるルーティング)
  post "posts/:id/update" => "posts#update"
  # 破棄機能(DBに変更を加えるルーティング)
  post "posts/:id/destroy" => "posts#destroy"

  get 'job_posts/interleaving', to: 'job_posts#interleaving'

  get "users/index" => "users#index"
  post "users/create" => "users#create"
  get "users/:id" => "users#show"
  get "users/:id/edit" => "users#edit"
  post "users/:id/update" => "users#update"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
