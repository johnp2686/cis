class AdminController < ApplicationController
  handles_sortable_columns

  before_filter :authenticate_user!
  before_filter :common_location_and_agent_details,:only => ["view_users","on_going_projects","sort_users","sort_on_going_claims"]
  before_filter :common_search_details, :only => ["on_going_projects","completed_projects","sort_on_going_claims","sort_completed_claims"]
  # load_and_authorize_resource
  before_filter :agents, :only => ["view_agents","sort"]
  include AdminHelper

 	def view_users
   if session[:admin]
    order = sortable_column_order
      if params[:search] and !params["reset"]
        model = EndUser
        @users = search(model, 'end_users',order)
      elsif params["reset"]
        @users = EndUser.order(order).paginate :page => params[:page],:conditions=>["agent_id is null"]
        params[:search]=nil      
      else
        @users = EndUser.order(order).paginate :page => params[:page], :conditions => ["agent_id is null"]
      end
    else
      flash[:alert]="You Don't have permission to access this page"
      redirect_to root_path
    end  
   	 #@users = EndUser.all
   end 

   def view_user_details

      @agents = EndUser.find(:all,:conditions =>["role_id=#{2}"])
      ######
      @user = EndUser.find(params[:id])
      
      if request.post?
        if params[:end_user][:agent_id].present?
           #EndUser.update(params[:agent][:role_id], {"agent_id" => params[:agent][:role_id]})
           @user.update_attributes(:agent_id => params[:end_user][:agent_id])
           flash[:success] ="Selected Agent added successfully"
           redirect_to :action => "view_users"
        else
           flash.now[:error] = "Please Select the Agent"  
        end 
      end   		
   end


   def common_location_and_agent_details
      @locations = EndUser.select("DISTINCT location").where("agent_id is null")
      role = Role.find_by_role("Agent")
      @agents= role.users
   end 

   def assign_agent
    if session[:admin]
      @records = params[:records].split(/,/)
      @records.each do |id|
        @user=EndUser.find(id)
        @usr = Customer.new
        if @user
          EndUser.update(id, {"agent_id" => params[:agent_id]})
          enduser = @usr.create_customer(id)
          enduser.save
        end 
      end  
      flash[:success] = "Agent assigned successfully to the selected users"
      redirect_to view_users_admin_index_path
    else
      flash[:alert]="You Don't have permission to access this page"
      redirect_to root_path
    end
   end

   def view_agent_details
    if session[:admin]
      role = Role.find_by_role("User")
      @agent = Agent.find(params[:id])
      @users = @agent.customers
      @end_users = EndUser.find_all_by_agent_id(params[:id])
      @other_users = User.find_all_by_agent_id(params[:id])
    else
      flash[:alert]="You Don't have permission to access this page"
      redirect_to root_path
    end
   end 

   def view_agents
    if session[:admin]
      order = sortable_column_order
     agent = Role.find_by_role("Agent")
     if params[:search] and !params["reset"]
        model = agent.users.order(order)
        @agents = search(model, 'users',order)
     elsif params["reset"]  
        @agents = agent.users.order(order).paginate :page => params[:page]
        params[:search]=nil
     else
       @agents = agent.users.order(order).paginate :page => params[:page]
     end   
    else
      flash[:alert]="You Don't have permission to access this page"
      redirect_to root_path
    end 
   end 
      
   def agent_project_details
    if session[:admin]
      @user = EndUser.find(params[:id])  
    else
      flash[:alert]="You Don't have permission to access this page"
      redirect_to root_path
    end  
   end 

   def agent_own_claim
    if session[:admin]
      @user = User.find(params[:id])
      @claims = @user.claims
    else
      flash[:alert]="You Don't have permission to access this page"
      redirect_to root_path
    end 
   end 

   def on_going_projects
     if session[:admin]
      order = sortable_column_order
      user = Role.find_by_role("User")
      if params[:search] and !params["reset"]
        model = User
        @users = search(model, "users",order)
      elsif params["reset"]
        if order == "policy_number asc" or order == "policy_number desc"   
          @users=user.users.joins(:claims).where(:claim_status => true, :completed_status => false).order(order) 
          params[:search]=nil
        else
          @users=user.users.where(:claim_status => true, :completed_status => false).order(order) 
          params[:search]=nil
        end  
      else
        if order == "policy_number asc" or order == "policy_number desc" 
          @users=user.users.joins(:claims).where(:claim_status => true, :completed_status => false).order(order) 
        else
          @users=user.users.where(:claim_status => true, :completed_status => false).order(order) 
        end  
      end  
     else
       flash[:alert] = "You Dont have permission to access this page"
       redirect_to root_path    
     end 
   end

   def view_on_going_project
    if session[:admin]
      @user = User.find(params[:id])
      @agent = User.find(@user.agent_id)
      @claims = @user.claims
    else
      flash[:alert]="You Don't have permission to access this page"
      redirect_to root_path
    end  
   end 

   def completed_projects
     if session[:admin]
      order = sortable_column_order
      user = Role.find_by_role("User")
      if params[:search] and !params["reset"]
        model = User
        @users = search(model, "users",order)
      elsif params["reset"]
        if order == "policy_number asc" or order == "policy_number desc" 
          @users = user.users.joins(:claims).where(:claim_status => true,:completed_status => true).order(order)
          params[:search] = nil
        else
          @users = user.users.joins(:claims).where(:claim_status => true,:completed_status => true).order(order)
          params[:search] = nil
        end  
      else
         if order == "policy_number asc" or order == "policy_number desc"
           @users = user.users.joins(:claims).where(:claim_status => true,:completed_status => true).order(order)
         else
           @users = user.users.where(:claim_status => true,:completed_status => true).order(order)
         end  
      end 
     else
       flash[:alert] = "You Dont have permission to access this page"  
       redirect_to root_path
     end 
   end 

  def view_completed_project
    if session[:admin]
      @user = User.find(params[:id])
      @agent = User.find(@user.agent_id)
      @claims = @user.claims
    else 
      flash[:alert]="You Don't have permission to access this page"
      redirect_to root_path
    end  
  end 

  def common_search_details
    role = Role.find_by_role("Agent")
    user_role = Role.find_by_role("User")
    @agents_search=role.users 
    @users_search = user_role.users
    @claims_search = Claim.all
  end  

  def view_agent_user_conversations
    @user = User.find(params[:id])
  end 

  def agents
    role = Role.find_by_role("Agent")
    @search_agents = role.users
  end  
  
  
  def view_users_conversations
    @user = User.find(params[:id])
    @questions = @user.questions
  end
  
  def sort
    model = User
    table = 'users'
    @sort = params[:sort]
      agent = Role.find_by_role("Agent")
      if params[:field] == 'user_name' or params[:field] == 'first_name' or params[:field] == 'last_name' or params[:field] == 'email' or params[:field] == 'mobile' and params[:sort] == 'up'
        @agents = agent.users.paginate(:page => params[:page],:order =>"#{params[:field]} asc")
      elsif params[:field] == 'user_name' or params[:field] == 'first_name' or params[:field] == 'last_name' or params[:field] == 'email' or params[:field] == 'mobile' and params[:sort] == 'down'
        @agents = agent.users.paginate(:page => params[:page],:order =>"#{params[:field]} desc")
      # else
      #   @user = generate_condition_for_sort(params[:sort],params[:field],model,table,@sql_conditions)

      end
     
  end

  def view_claims
    order = sortable_column_order
    role = Role.find(session[:user_role_id])
    if order == "policy_number asc" or order == "policy_number desc"
      # @users = role.users.joins(:claims).paginate(:page =>params[:page],:order => order)
       @claims = Claim.all    
    else
      @claims = Claim.all
      @users = role.users.paginate(:page =>params[:page],:order => order)
    end   
  end  

  def mass_approve_and_disapprove_claims
    @approve = params[:records].split(/,/)
    if params[:title]=="Approve"
      @approve.each do |id|  
          @users=User.find(id)
          if @users
            User.update(id, {"approved_status" => true})
          end 
      end
      flash[:success] = "Selected Records are approved"
      redirect_to request.referrer
    else
      if params[:title]=="Disapprove"
        @approve.each do |id|  
          @users=User.find(id)
          if @users
           User.update(id, {"approved_status" => false})
          end 
        end
        flash[:success] = "Selected Records are disapproved"
        redirect_to request.referrer 
      end   
    end  
  end  

  def agent_customer_messages
    claim = Claim.find(params[:id])
    @customer = claim.customer
    @agent = claim.try(:agent)
    @messages = claim.sentstatuses.all(:order =>"created_at DESC")
  end

end
