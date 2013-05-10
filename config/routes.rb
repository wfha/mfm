Mfm::Application.routes.draw do

  devise_for :users, controllers: {
      confirmations:      'users/confirmations',
      passwords:          'users/passwords',
      registrations:      'users/registrations',
      sessions:           'users/sessions',
      unlocks:            'users/unlocks',
      omniauth_callbacks: 'users/omniauth_callbacks'
  }

  match '/delayed_job' => DelayedJobWeb, :anchor => false

  match 'admin/index'                 => 'admin#index',              :as => :admin_index
  match 'admin/users'                 => 'admin#users',              :as => :admin_users
  match 'admin/orders'                => 'admin#orders',             :as => :admin_orders
  match 'admin/handle_order/:id'      => 'admin#handle_order',       :as => :admin_handle_order
  match 'admin/handle_ticket/:id'     => 'admin#handle_ticket',      :as => :admin_handle_ticket
  match 'admin/order_modal/:id'       => 'admin#order_modal',        :as => :admin_order_modal
  match 'admin/create_transaction'    => 'admin#create_transaction', :as => :admin_create_transaction
  match 'admin/create_redeem'         => 'admin#create_redeem',      :as => :admin_create_redeem

  match 'home/index'                  => 'home#index',               :as => :home_index
  match 'home/stores'                 => 'home#stores',              :as => :home_stores
  match 'home/delivery'               => 'home#delivery',            :as => :home_delivery
  match 'home/grocery'                => 'home#grocery',             :as => :home_grocery
  match 'home/coupons'                => 'home#coupons',             :as => :home_coupons
  match 'home/plans'                  => 'home#plans',               :as => :home_plans

  match 'home/store_overview/:id'     => 'home#store_overview',      :as => :home_store_overview
  match 'home/store_info/:id'         => 'home#store_info',          :as => :home_store_info
  match 'home/store_good/:id'         => 'home#store_good',          :as => :home_store_good
  match 'home/store_menu/:id'         => 'home#store_menu',          :as => :home_store_menu
  match 'home/store_promo/:id'        => 'home#store_promo',         :as => :home_store_promo
  match 'home/store_review/:id'       => 'home#store_review',        :as => :home_store_review
  match 'home/load_store_good/:id'    => 'home#load_store_good',     :as => :home_load_store_good
  match 'home/load_store_info/:id'    => 'home#load_store_info',     :as => :home_load_store_info
  match 'home/load_store_review/:id'  => 'home#load_store_review',   :as => :home_load_store_review
  match 'home/print_coupon/:id'       => 'home#print_coupon',        :as => :home_print_coupon
  match 'home/dish_modal/:id'         => 'home#dish_modal',          :as => :home_dish_modal

  match 'home/paypal_notify'          => 'home#paypal_notify',       :as => :home_paypal_notify
  match 'home/paypal_cancel'          => 'home#paypal_cancel',       :as => :home_paypal_cancel

  match 'home/phone_start'            => 'home#phone_start',         :as => :home_phone_start
  match 'home/phone_end'              => 'home#phone_end',           :as => :home_phone_end
  match 'home/phone_test'             => 'home#phone_test',          :as => :home_phone_test

  resources :advertisements
  resources :carts do
    member do
      get :type
    end
  end
  resources :cart_items
  resources :orders
  resources :payments
  resources :posts
  resources :roles
  resources :services
  resources :tags
  resources :tickets
  resources :transactions

  resources :stores do
    resources :coupons, :dish_choices, :dish_features, :dish_discounts, :hours, :menus, :plans
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
