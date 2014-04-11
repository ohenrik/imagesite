Imagesite::Application.routes.draw do

  resources :public_themes

    get "password_resets/new"
    get 'register', to: 'users#new', as: 'register'
    get 'login', to: 'sessions#new', as: 'login'
    get 'logout', to: 'sessions#destroy', as: 'logout'
    get 'home', to: 'static_pages#home', as: 'home'

    resources :sessions

    resources :password_resets


   #Check for subdomain
    constraints(Subdomain) do

        # Pages
        get 'pages/:id/toggle_status' => 'pages#toggle_status', as: :toggle_page_status
        get 'pages/:id/settings' => 'pages#settings', as: :page_settings
        get 'pages/gallery_modal' => 'pages#gallery_modal', as: :pages_gallery_modal
        post 'pages/add_to_menu/:id' => 'pages#add_to_menu', as: :add_page_to_menu 
        post 'pages/add_to_page/:id' => 'pages#add_to_page', as: :add_page_to_page
        post 'pages/:id/add_other_page_item' => 'pages#add_other_page_item', as: :add_other_page_item
        resources :pages

        # Page Items
        get 'page_items/:id/settings' => 'page_items#settings', as: :page_item_settings
        post 'page_items/sort_page_items' => 'page_items#sort', as: :sort_page_items
        resources :page_items

        # Photos
        get 'photos/all' => 'photos#all', as: :all
        get 'photos/thumbnail_modal' => 'photos#thumbnail_modal', as: :thumbnail_modal
        post 'photos/:id/set_as_thumbnail' => 'photos#set_as_thumbnail', as: :set_thumbnail
        get 'photos/all/tags/:tag' => 'photos#all', as: :filter_tag
        get 'photos/gallery_modal' => 'photos#gallery_modal', as: :photos_gallery_modal
        get 'photos/photos_modal' => 'photos#photo_manager_modal', as: :photo_manager_modal
        post 'photos/add_to_page/:id' => 'photos#add_to_page', as: :add_photo_to_page
        resources :photos

        # Tags
        get 'tags/:tag' => 'photos#index', as: :public_filter_tag
        post 'tags/add_to_menu/:id' => 'tags#add_to_menu', as: :add_tag_to_menu
        resources :tags

        # Themes
        get 'themes/select_theme/:id' => 'themes#select_theme', as: :select_theme
        resources :themes do
          resources :code_files
        end
        # Menu Items
        post 'menu_items/sort_menu_items/:id' => 'menu_items#sort', as: :sort_menu_items
        resources :menu_items


        # Menus 
        resources :menus

        # Set a page as the home screen
        post 'pages/set_home/:id' => 'pages#set_home', as: :set_home_page

        # User selected Home screen
        get "/" => 'users#home'

    end

    # Users
    get "settings/:id" => 'users#settings', as: :settings
    patch "settings/:id/update" => 'users#update_settings', as: :update_settings
    # User alias domain
    patch "settings/:id/set_alias_domain" => 'users#set_alias_domain', as: :set_alias_domain
    patch "settings/:id/remove_alias_domain" => 'users#remove_alias_domain', as: :remove_alias_domain
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
