Rails.application.routes.draw do
  resources :texts
  # resources :messages
  resources :posts
  resources :profiles
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  root 'comments#index' # ここを追記します
  get 'comments/index' # 自動で設定されたルーティング
end
