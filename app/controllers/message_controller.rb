class MessageController < ApplicationController
  before_filter :current_role

  def agent_customer_message
    if current_role == "Admin"
      # Sentstatus.find(params[:id]).update_attributes(:is_viewed => true)
    elsif current_role == "Agent" 
      Sentstatus.find(params[:id]).update_attributes(:is_agent_viewed => true)
    else
      Sentstatus.find(params[:id]).update_attributes(:is_customer_viewed => true)
    end
    @message = Sentstatus.find(params[:id])
  end

  def inbox_messages
    if current_role == "Agent"
      @messages = Agent.find(current_user).try(:sentstatuses).where("is_agent_viewed=?", false).order("created_at DESC")
      @viewed = Agent.find(current_user).try(:sentstatuses).where("is_agent_viewed=?", true).order("created_at DESC")
    elsif current_role == "User"
      @messages = Customer.find(current_user).try(:sentstatuses).where("is_customer_viewed=?", false).order("created_at DESC")
      @viewed = Customer.find(current_user).try(:sentstatuses).where("is_customer_viewed=?", true).order("created_at DESC")
     else 
      @messages = Sentstatus.all.where("is_viewed=?", false)
      @viewed = Sentstatus.all.where("is_viewed=?", true)
    end 
  end

  def customer_reply
      @message = Sentstatus.find(params[:id])
      @to_email = @message.agent.email
    if request.get?
      @message
    else request.post?
      claim_id = Claim.last.id
       params[:message].merge!(:claim_id => claim_id, :user_id => "1", :from => current_user.email, 
       :agent_id => @message.agent.id, :is_agent_viewed => false, :customer_id => current_user.id )
      @sa = Sentstatus.new(params[:message])
      if  @sa.save
        UserMailer.agent_status_mail(@sa.to, @sa.subject, @sa.message).deliver
        flash[:success] = "Mail sent successfully"
        redirect_to message_inbox_messages_url
      else
        render 'add_send_status'
      end  
    end
  end
  
  private

  def current_role
    case current_user.roles.last.role
    when "Admin"
      "Admin"
    when "Agent"
      "Agent"
    when "User"
      "User"
    end
  end

end
