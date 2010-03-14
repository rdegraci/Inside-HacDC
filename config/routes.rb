ActionController::Routing::Routes.draw do |map|
  map.resources :occupants

  #main entry point for User Announce
  #redirected here from Jukebox
  map.jukebox_gateway "occupants/gateway/:hashcode",
    :controller => "occupants",
    :action => "gateway_entry"

  #hashcode passed via via flash from gateway_entry
  map.occupant_login "occupants/login;recognized",
    :controller => "occupants",
    :action => "user_login"

  map.internet_gateway "occupants/login;internet",
    :controller => "occupants",
    :action => "internet_login"

  #hash passed in via internet_login
  map.show_occupant_data "occupants/show;recognized",
    :controller => "occupants",
    :action => "user_show"

  #hashcode passed via flash
  map.occupant_edit "occupants/edit;recognized",
    :controller => "occupants",
    :action => "user_edit"

  #hashcode passed via flash
  map.occupant_new "occupants/new;unknown",
    :controller => "occupants",
    :action => "user_new"

  map.resources :devices


  map.join "messages/joinhacdc",
    :controller => "messages",
    :action => "joinhacdc"

  map.twittererr "messages/twitterfail",
    :controller => "messages",
    :action => "twitterfail"
  map.resources :messages



  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "messages"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
