class AgentController < ApplicationController
  layout Proc.new { |controller| controller.request.xhr? ? false : 'application' }
  handles_sortable_columns
  before_filter :authenticate_user!
  # load_and_authorize_resource
  skip_authorization_check
  before_filter :set_current_user

  def index
    @end_users = EndUser.all
  end
  
  def view_users
    order = sortable_column_order
    @users = EndUser.search(params[:search]).end_users.order(order)
  end

  def agent_users

    order = sortable_column_order
    if order == "policy_number asc" or order == "policy_number desc"   
      # @users = User.joins(:claims).find(:all,:conditions => ["agent_id =?", current_user.id],:order => order)
      # @users = Agent.find(current_user.id).customers.includes(:claims)
      @users = Customer.includes(:claims).find_all_by_agent_id(current_user.id)  
      @user = User.new
    else
      @users = Customer.includes(:claims).find_all_by_agent_id(current_user.id)  
      @user = User.new
    end  
  end

# def add_send_status
#     @user = User.find(params[:id])
#     @sendstatus = Sentstatus.new
#     @iw=@user.id
#     # @userquatation = params[:userquotation]
#     # if @userquatation == "quotationlist"
#     #   @maillist = Userquotationmail.all
#     # end
#     if request.post?
#       @sendstatus = @user.sentstatuses.build(params[:sentstatus])
#       if @sendstatus.save
#         @user.sentstatuses.each do |usersendmail|
#           @usersendmail = usersendmail 
#         end
#       UserMailer.agent_status_mail(@user,@usersendmail).deliver
#       flash[:success] = "Mail sent successfully"
#       redirect_to agent_view_users_path
#       end
#     end  
#   end 


  def add_send_status

    if request.get?
      @dd = User.find(params[:id])
      @mail_id = @dd.email
      @iw=@dd.id
    else request.post?
      @dd = Customer.find(params[:id])
      @mail_id = @dd.email
      @iw=@dd.id
      @sub=params[:send_status][:subject]
      @editor=params[:send_status][:message]
      params[:send_status].merge!(:claim_id => params[:claim_id],:user_id => "1", :from => current_user.email, 
        :to => @mail_id, :subject => @sub, :message => @editor, 
        :agent_id => current_user.id, :is_customer_viewed => false )
      @sa = @dd.sentstatuses.build(params[:send_status])

      if  @sa.save
        UserMailer.agent_status_mail(@mail_id,@sub,@editor).deliver
        flash[:success] = "Mail sent successfully"
        redirect_to agent_agent_users_path
      else
        render 'add_send_status'
      end  
    end 
end
  
  def new_claim
     if request.get?
        new_user = User.new
        @user = new_user.create_user(params[:id])
      if @user.save(:validate => false)
        UserRole.create(:user_id => @user.id, :role_id => session[:user_role_id])
        end_user = EndUser.find(params[:id])
        end_user.update_attributes(claims_status:"true")
      else
        @user = User.find_by_email(@user.email)
      end
    else request.post?
      @user = User.find(params[:id])
      @claim = @user.claims.build(params[:claim])
      if @user.save(:validate => false) && @claim.save
        redirect_to agent_view_users_path, flash[:success] => "Claim created Successfully"
      else
        redirect_to agent_new_claim_path(:id => user.id), flash[:success] => "Required fields shoud not be blank"
      end
    end
  end

  def agent_claims
    if request.put?
      @claim = Claim.find(params[:claim_ids])
      @claim.each { |c| c.update_attributes(:claim_status => params[:claim_status])}
      flash[:success] = "Claim Status Successfully Updated"
    end
    @claims = Agent.find(current_user).claims

  end

  def pending_claims
    @claims = Claim.includes(:users).where("agent_id","#{current_user.id}" , "claim_status","pending")
  end

  def completed_claims
    @users = User.find(:all,:conditions => ["agent_id =? and claim_status =? and completed_status =?","#{current_user.id}",true,true])
  end

  def in_process_claims
    order = sortable_column_order
    if order == "policy_number asc" or order == "policy_number desc"   
      # @users = User.joins(:claims).find(:all,:conditions => ["agent_id = ? and claim_status = ? and completed_status = ?","#{current_user.id}",true,false],:order=>order)
      @users = Agent.find(current_user.id).claims.find_all_by_claim_status("Processing")
    else
      @users = Agent.find(current_user.id).claims.find_all_by_claim_status("Processing")
      # @users = User.search(params[:search]).find(:all,:conditions => ["agent_id = ? and claim_status = ? and completed_status = ?","#{current_user.id}",true,false],:order=>order)
    end  
  end  

  def create_user
    @agent = Agent.find(current_user.id)
    @user = @agent.customers.create(params[:user])
    @userid = @user.id
    respond_to do |format|
      if @user.errors.full_messages.size == 0
        UserRole.create(:user_id => @user.id, :role_id => session[:user_role_id])
        format.json {
          render :json => {
          :user => @user.to_json,
          :userid => @userid.to_json
          }
        }
      else
        format.json {render :json => { :errors => @user.errors.full_messages }, :status => 422}
      end  
    end
  end

  def add_quotation
   if request.post?   
      @from = current_user.email
      @to = params[:att_quote][:to]
      @subject = params[:att_quote][:subject]
      @message = params[:att_quote][:message].gsub(/\r\n?/, "\n")
      @quote = Quotation.create!(:quotation => params[:quotation][:quotation])
      UserMailer.sent_quotation(@from,@to,@subject,@message,@quote).deliver
      redirect_to :back, :flash => { :success => "Mail sent successfully" }
    else
      @quotation = Quotation.new()   

    end
  end
  
  def add_claim
    if request.get?
      @user = Customer.find(params[:id])
      @claim = @user.claims.build
    elsif request.post?
      # raise params.inspect
      @user = Customer.find(params[:id])
      params[:customer][:claims_attributes].values_at("0").first.merge!(:agent_id => "#{current_user.id}")
      @claim = @user.claims.build(params[:customer][:claims_attributes].values_at("0"))
      # raise @claim.inspect
      @claim.first.save ?
        (redirect_to agent_agent_users_path, :flash => {:success => "Claim Successfully created "} ) : 
        (redirect_to :back , :flash => { :success => "Required fileds cant be blank" })
    end
  end


end
