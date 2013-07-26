module AdminHelper
 def search(model, table,order)
    sql_condition = '1'
    if params[:controller] == "admin" and params[:action] == "view_users"
	   unless params[:search][:location_id].blank?
       sql_condition += " and agent_id is null and location LIKE '%#{params[:search][:location_id]}%'"
       @location = params[:search][:location_id]
     else
       sql_condition += " and agent_id is null"  
     end
    end
     
    if params[:controller] == "admin" and params[:action] == "on_going_projects"
     unless params[:search][:agent_id].blank?
       sql_condition += " and #{table}.agent_id is not null and #{table}.claim_status=#{true} and #{table}.completed_status=#{false} and agent_id = #{params[:search][:agent_id]}"
       @agent = params[:search][:agent_id]
     else
       sql_condition += " and #{table}.agent_id is not null and #{table}.claim_status=#{true} and #{table}.completed_status=#{false}"  
     end

     
     unless params[:search][:user_name].blank?
       sql_condition += " and #{table}.agent_id is not null and #{table}.claim_status=#{true} and #{table}.completed_status=#{false} and #{table}.id=#{params[:search][:user_name]}"
       @user_name = params[:search][:user_name]
     else
       sql_condition += " and #{table}.agent_id is not null and #{table}.claim_status=#{true} and #{table}.completed_status=#{false}"  
     end

    end

    if params[:controller] == "admin" and params[:action] == "completed_projects"
      
     unless params[:search][:agent_id].blank?
       sql_condition += " and #{table}.agent_id is not null and #{table}.claim_status=#{true} and #{table}.completed_status=#{true} and agent_id = #{params[:search][:agent_id]}"
       @agent = params[:search][:agent_id]
     else
       sql_condition += " and #{table}.agent_id is not null and #{table}.claim_status=#{true} and #{table}.completed_status=#{true}"   
     end

     unless params[:search][:user_name].blank?
       sql_condition += " and #{table}.agent_id is not null and #{table}.claim_status=#{true} and #{table}.completed_status=#{true} and #{table}.id=#{params[:search][:user_name]}"
       @user_name = params[:search][:user_name]
     else
       sql_condition += " and #{table}.agent_id is not null and #{table}.claim_status=#{true} and #{table}.completed_status=#{true}"  
     end

    end 

    if params[:controller]== "admin" && params[:action] == "view_agents"   
      unless params[:search][:user_name].blank?
        sql_condition += " and #{table}.id=#{params[:search][:user_name]}"
        @user_name = params[:search][:user_name]
      end
      unless params[:search][:email].blank?
        sql_condition += " and #{table}.id=#{params[:search][:email]}"
        @email = params[:search][:email]
      end 
      unless params[:search][:location].blank?
        sql_condition += " and #{table}.id=#{params[:search][:location]}"
        @location = params[:search][:location]
      end 

    end 
    if order == "policy_number asc" or order == "policy_number desc"
      model.joins(:claims).order(order).paginate :page => params[:page], :conditions => sql_condition
    elsif order
      model.order(order).paginate :page => params[:page], :conditions => sql_condition
    else
       model.paginate :page => params[:page], :conditions => sql_condition
     end  
  end


  def agent_name(agent_id)
  	@agent = User.find(agent_id)
  end	

  def generate_condition_for_sort(sort,field,model,action)
    if action == "sort_on_going_claims"
      if params[:field] == "policy_number" and sort == 'up'
        model.joins(:claims).where(:claim_status => true, :completed_status => false).order("#{field} asc")
      elsif params[:field] == "policy_number" and sort == 'down'
        model.joins(:claims).where(:claim_status => true, :completed_status => false).order("#{field} desc")    
      end
    else
       if params[:field] == "policy_number" and sort == 'up'
        model.joins(:claims).where(:claim_status => true, :completed_status => true).order("#{field} asc")
      elsif params[:field] == "policy_number" and sort == 'down'
        model.joins(:claims).where(:claim_status => true, :completed_status => true).order("#{field} desc")    
      end   
    end 
  end  
  
end
