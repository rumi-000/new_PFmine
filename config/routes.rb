Rails.application.routes.draw do

  root :to => "user/homes#top"
  get "about" => "user/homes#about", as: "about"
  get "choice" => "user/homes#choice", as: "choice"
  get "admin" => "admin/homes#top", as: "admin"
  get "search" => "user/searches", as: "search"
  get "admin/search" => "admin/users#search", as: "admin/search"
  get 'user/:user_id/favorites' => "user/favorites#index", as: 'user_favorites'
  post "/" => "user/homes#top"
  
  #管理者側 カリキュラム通りに記載している。
  #app/views/admin/shared/_links.html.erbでコメントアウトしてる。
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }
  
  namespace :admin do
  resources :tags, only: [:index, :new, :edit, :update, :create, :destroy]
  resources :users, only: [:index, :show, :update]
  resources :chats, only: [:index, :destroy]
  end
  

  #ユーザー側 カリキュラム通りに記載している。
  #app/views/user/shared/_links.html.erbでコメントアウトしてる。
  devise_for :users, skip: [:passwords], controllers: {
  registrations: "user/registrations",
  sessions: 'user/sessions'
  }

  # ゲストログインのルーティング
  devise_scope :user do
  post 'user/guest_sign_in', to: 'user/sessions#guest_sign_in'
  end
  
 

 scope module: 'user' do
  
  resources :users, only: [:show, :edit, :update] do
   
   # 退会機能のルーティング
   collection do
    #confirm_withdraw アクション：退会確認画面の表示
   get 'confirm_withdraw'
    #withdraw アクション：退会実行処理の実行s
   patch 'withdraw'
   end
 
  end
  
 resources :posts, only: [:new, :create, :show, :index, :edit, :update, :destroy] do
  resource :favorites, only: [:create, :destroy, :index]
 resources :post_comments, only: [:create, :destroy]
 end
 
 resources :tags, only: [:index, :show]
 resources :chats, only: [:new, :create, :index]
 
 end
 
end


