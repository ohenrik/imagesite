Imagesite::Application.routes.draw do

  



  resources :page_items

  get "password_resets/new"
  get 'register', to: 'users#new', as: 'register'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'home', to: 'static_pages#home', as: 'home'
  
  resources :sessions
  
  resources :password_resets


   #Check for subdomain
  constraints(Subdomain) do
    get 'photos/all' => 'photos#all', as: :all
    get 'tags/:tag' => 'photos#index', as: :public_filter_tag
    get 'photos/all/tags/:tag' => 'photos#all', as: :filter_tag
    get 'themes/select_theme/:id' => 'themes#select_theme', as: :select_theme
    post 'pages/set_thumbnail/:id' => 'pages#set_thumbnail', as: :set_thumbnail
    post 'pages/add_to_menu/:id' => 'pages#add_to_menu', as: :add_page_to_menu 
    post 'tags/add_to_menu/:id' => 'tags#add_to_menu', as: :add_tag_to_menu
    post 'menu_items/sort_menu_items/:id' => 'menu_items#sort', as: :sort_menu_items
    resources :pages
    resources :photos
    resources :tags
    resources :themes
    resources :menu_items
    resources :menus
    
    get "/settings/:id" => 'users#settings', as: :settings


    # Set a page as the home screen
    post 'pages/set_home/:id' => 'pages#set_home', as: :set_home_page

    # User selected Home screen
    get "/" => 'users#home'

  end

  resources :users

  root :to => 'static_pages#home'


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
