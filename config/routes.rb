Rails.application.routes.draw do
  get 'main/index'

  get "install/setting"
  get "install/user"
  get "install/setcity"
  get "v2"=>'main#two'

  resources :forums
  resources :topics
  resources :logs

  resources :provinces
  resources :routes
  resources :asks, :path => 'wenda'

  #用户相关
  match 'login' => 'users#login', :as => 'login', :via => [:get, :post]
  match 'register' => 'users#register', :as => 'register', :via => [:get, :post]
  post 'users/create' => 'users#create'
  post 'users/ajax' => 'users#ajax'
  get 'user/logout' => 'users#logout'

  #会员个人主页
  resources :u, :only => [:show] do |u|
    member do
      #get 'albums'
      match '/albums'=>'u#albums',:as=>'albums',:via=>[:get]
      match '/albums_upload'=>'u#albums_upload',:as=>'albums_upload',:via=>[:get,:post]
      match '/album/:aid' => 'u#album', :constraints => {:aid => /\d/}, :as => 'album_show',:via=>[:get]
    end
  end

  #目的地
  resources :places do
    member do
      get 'photos'
      post 'wantgoto'
      post 'beento'
    end
    collection do
      match 'city/:name' => 'places#city', :constraints => {:name => /[a-zA-z1-9]+/}, :as => 'city',:via=>:get
      match 'area/:name' => 'places#area', :constraints => {:name => /[a-zA-z1-9]+/}, :as => 'area',:via=>:get
    end
  end

  #照片
  resources :photos do
    collection do
      post :upload
    end
  end

  #resources :photos,:path_names => {:new => "upload"}

  #问答
  resources :asks, :path => 'wenda'

  #攻略
  resources :guides

  #评论
  resources :comments do
    collection do
      get 'list', :to => "comments#list",:as => 'list'
      get :show
      get :getone
    end
  end

  #论坛
  resources :forums,:except => [:show] do
    collection do
      #话题
      resources :topics,:except => [:show] do
        collection do
          get 'post', :to => "topics#new",:as => 'post'
          get ':id', :to => "topics#show",:constraints => {:id => /[\d]+/},:as => 'show'
        end
      end
      #resources :topics, :except => [:new], :path_names => {:new => "post"}
    end
  end


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'main#index', :as => 'main'

  #管理员路径
  get "admin" => 'admin#frame', :as => 'admin'
  post 'admin/login' => 'admin#login'
  namespace :admin do |admin|
    resources :ads
    resources :main
    resources :forums
    resources :places
    resources :users
    resources :options
    resources :comments
    resources :recommends
    resources :managers
    resources :guides
    resources :articles
  end

  #常见的，下面这句最好放在页面最后一行
  match ':controller(/:action(/:id))(.:format)', :constraints => {:id => /[\d]+/}, :via => [:get]
  #上述這一行設定就包括六種路徑方式：

  #match '/:controller'
  #match '/:controller/:action'
  #match '/:controller/:action/:id'
  #match '/:controller.:format'
  #match '/:controller/:action.:format'
  #match '/:controller/:action/:id.:format'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
