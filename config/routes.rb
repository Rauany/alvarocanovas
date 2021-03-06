# -*- encoding : utf-8 -*-
Alvarocanovas::Application.routes.draw do

  devise_for :users,
             :path => "admin",
             :path_names => { :sign_in => 'login', :sign_out => 'logout' }

#  devise_for :users do
#    get "admin/login" => "devise/sessions#new", :as => :login
#    get "admin/logout" => "devise/sessions#destroy", :as => :logout
#  end
  

  #match "admin" => "admin/categores#index", :as => :user_root  

  namespace 'admin' do
    resource :owner, :only => [:edit, :update, :show]
    resources :users
    resources :videos do
      get :authorize, :reorder, :on => :collection
    end
    resources :contents
    resources :publications do
      get 'reorder', :on => :collection
    end
    match 'top_list_pictures' => "pictures#top_list"
    match "remove_picture_from_top_list/:id" => "pictures#remove_from_top_list", :as => 'remove_picture_from_top_list'

    match 'edit_contact' => "contents#edit_contact_page"
    match 'update_contact' => "contents#update_contact_page"

    resources :categories do
      collection do
        get :reorder, :list
      end
      new do
        get :cancel
      end
      resources :pictures do
        collection do
          get :reorder
        end
      end
    end
    root :to => 'categories#index'
  end

  #match "admin", :to => 'admin/categories#index'
  


  scope "(:locale)", :locale => /fr|en/ do
    resources :categories, :only => [:index, :show] do
      resources :pictures, :only => [:index, :show]
    end
    resources :messages, :only => [:show, :create]
    resources :videos, :only => [:index, :show]
    resources :publications, :only => :index
    resources :contents, :only => :show
    match 'contact' => 'contents#contact', :as => "contact"
    root :to => 'categories#index'
  end  



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
  #       get :short
  #       post :toggle
  #     end
  #
  #     collection do
  #       get :sold
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
  #       get :recent, :on => :collection
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
#   root :to => "admin/categories#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
