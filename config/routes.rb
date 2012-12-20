Mfm::Application.routes.draw do

  devise_for :users

  match 'home/index' => 'home#index', :as => :home_index
  match 'home/stores' => 'home#stores', :as => :home_stores
  match 'home/store_good/:id' => 'home#store_good', :as => :home_store_good
  match 'home/store_menu/:id' => 'home#store_menu', :as => :home_store_menu
  match 'home/store_info/:id' => 'home#store_info', :as => :home_store_info
  match 'home/store_reviews/:id' => 'home#store_reviews', :as => :home_store_reviews
  match 'home/coupons' => 'home#coupons', :as => :home_coupons
  match 'home/plans' => 'home#plans', :as => :home_plans
  match 'home/dish_modal/:id' => 'home#dish_modal', :as => :home_dish_modal

  resources :carts
  resources :cart_items
  resources :orders
  resources :payments
  resources :roles
  resources :tags

  resources :stores do
    resources :coupons, :dish_choices, :dish_features, :hours, :menus, :plans
  end

  resources :menus do
    resources :categories
  end

  resources :categories do
    resources :dishes
  end

  root :to => 'home#index'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
