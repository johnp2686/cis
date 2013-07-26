class DashboardController < ApplicationController
  def index
    user = Role.find_by_role("User")
    agent = Role.find_by_role("Agent")
    admin = Role.find_by_role("Admin")

    session[:user_role_id] = user.id
    session[:agent_role_id] = agent.id
    session[:admin_role_id] = admin.id

    if current_user
      if !current_user.user_roles.where(:role_id=>admin.id).blank?
        session[:admin] = current_user.id
      end
      if !current_user.user_roles.where(:role_id=>agent.id).blank?
        session[:agent] = current_user.id
      end
      if !current_user.user_roles.where(:role_id=>user.id).blank?
        session[:user] = current_user.id
      end
    end

    if session[:admin]
      #@users = EndUser.find(:all,:conditions=>["date(created_at) between date_sub(now(),interval #{Date.today.wday} day) and now() and agent_id is null" ],:limit => 5,:order => "created_at desc") 
      @users = EndUser.find(:all,:conditions => ["agent_id is null"])
      @val = []
      @val1 = []
      @month = []  
      @users_months = @users.group_by { |t| t.created_at.strftime("%b") }  
        
       @users_months.each do |m,u|
        @val << u.count
        @month << m
      end 

      @on_going_months = []
      @on_going_claims = []
      @completed_months = []
      @completed_claims = []
      @on_going=user.users.where(:claim_status => true, :completed_status => false) 
      @result = @on_going.group_by { |t| t.created_at.strftime("%b") }
      @result.each do |m,c|  
        @on_going_claims << c.count
        @on_going_months << m    
      end 
      @completed = user.users.where(:claim_status => true,:completed_status => true)
      @result1 = @completed.group_by { |t| t.completed_at.strftime("%b")}
      @result1.each do |m,c|
        @completed_months << m
        @completed_claims << c.count
      end  

      @combine = @on_going_months + @completed_months
      @combine_months = @combine.uniq
      
    end
    
    else if session[:agent]

        @users = EndUser.find(:all,:conditions => ["agent_id is null"])
      @val = []
      @val1 = []
      @month = []  
      @users_months = @users.group_by { |t| t.created_at.strftime("%b") }  
        
       @users_months.each do |m,u|
        @val << u.count
        @month << m
end
       @on_going_months = []
      @on_going_claims = []
      @completed_months = []
      @completed_claims = []
      @on_going=user.users.where(:claim_status => true, :completed_status => false) 
      @result = @on_going.group_by { |t| t.created_at.strftime("%b") }
      @result.each do |m,c|  
        @on_going_claims << c.count
        @on_going_months << m    
      end 
      @completed = user.users.where(:claim_status => true,:completed_status => true)
      @result1 = @completed.group_by { |t| t.completed_at.strftime("%b")}
      @result1.each do |m,c|
        @completed_months << m
        @completed_claims << c.count
      end  

      @combine = @on_going_months + @completed_months
      @combine_months = @combine.uniq
      
    end
  


  end


 
  




end
