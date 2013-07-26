CisNew::Application.routes.draw do

  # get "home/index"
  
  match "agent/new_claim" => 'agent#new_claim',  :via => [:get, :post]
  match "comments/add_question" => "comments#add_question", :via => [:get,:post]
  match "comments/add_answer" => "comments#add_answer", :via => [:get, :post]
  match "agent/add_claim" => "agent#add_claim", :via => [:get, :post]
  match "agent/add_send_status/:id" => "agent#add_send_status",:as=>"add_send_status" ,:via => [:get, :post]
  match "agent/add_quotation" => "agent#add_quotation",:as => "add_quotation",:via => [:get, :post]
  match "message/customer_reply" => "message#customer_reply", :via => [:get, :post]
  get "agent/index"
  get "agent/view_users"
  get "agent/agent_claims"
  get "agent/agent_users"
  get "agent/agent_charts"
  get "agent/in_process_claims"
  get "agent/completed_claims"
  get "message/agent_customer_message"
  get "message/inbox_messages"
  match "users/confirm" => 'users#confirm', :via => :get
  # match "claims/enduserclaims/(:userclaims)" => 'claims#enduser_listclaims',:as => 'enduser_listclaims',:userclaims => "allclaims"
  # match "claims/userclaims" => 'claims#enduser_listclaims',:as => 'enduser_listclaims'
  match "end_users/enduserclaims/(:userclaims)" => 'end_users#enduser_listclaims',:as => 'enduser_listclaims',:userclaims => "allclaims", :via => :get
  match "customer/claim_status" => 'end_users#claim_status', :as => 'claim_information', :via => :get

  devise_for :users
  
  resources :end_users do
    collection do
      get :register
    end
  end
  
  resources :claims do
    member do
      get :enduser_upload
      put :enduser_upload_update
      delete :enduser_uploadedfiles
    end
      resources :policy_photos, :only => [:create, :destroy]
    # collection do
    #   put :enduser_upload_update
    # end
  end
  resources :users do
    collection do
      get :all_querries
      get :send_mail
      post :send_mail
      get :view_agents
      put :upload_claim_details
      get :upload_claim_details
      # get :user_upload
    end
    # resources :questions do
      member do
        get :add_answer
        post :add_answer
      end
    # end
   resources :comments
  end

  resources :admin do
    collection do
     get "view_users"
     get "assign_agent"
     post "assign_agent"
     get "view_agents"
     get "on_going_projects"
     get "completed_projects"
     get "create_agent"
     get "sort"
     get "view_claims"
     get "mass_approve_and_disapprove_claims"
    end
    member do
      get :agent_customer_messages
      get :view_user_details  
      get :view_agent_details
      get :agent_project_details
      get :agent_own_claim
      get :view_on_going_project
      get :view_completed_project
      get :view_agent_user_conversations
      get :view_users_conversations
    end 
   end


   match ':controller(/:action(/:id))(.:format)'
   # root :to => 'dashboard#index' if current_user
   root :to => "home#index"

end
