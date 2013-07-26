class UsersController < ApplicationController
  
  before_filter :authenticate_user!
  load_and_authorize_resource :except => [:all_querries, :add_answer,:send_mail,:claim_status,:view_agents,:upload_claim_details,:user_upload,:enduser_listclaims]
  respond_to :json

  def index
   
  end
  
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        agent= Role.find_by_role("agent")
        UserRole.create(:user_id => @user.id,:role_id =>agent.id)
        # flash[:success] = "Agent created successfully"
        # redirect_to view_agents_admin_index_path
        format.html { redirect_to @user, notice: 'Claim was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

   def add_answer
    if request.get?
      @question = Question.find_by_id(params[:id])
      @answer = @question.answers.build
    end
    if request.post?
       # raise params.inspect
      @question = Question.find_by_id(params[:id])
      @answer = @question.answers.build(params[:answer])
      if @answer.save
        flash[:success] = "Answer posted successfully"
        redirect_to root_path 
      else
        render 'add_answer'
      end
     
    end
  end

  def all_querries
    @questions = Question.find(:all)
  end


  def create_agent
    @user = Agent.create(params[:user])
    if @user.errors.full_messages.size == 0
      UserRole.create(:user_id => @user.id,:role_id => session[:agent_role_id])
       render :json => @user.to_json
    else
      render :json => { :errors => @user.errors.full_messages }, :status => 422
    end  
  end 

  def claim_status
    @user = User.find(current_user.agent_id)
  end  

  def send_mail
      @user = User.find_by_email(params[:email])

      if request.post?
        params.merge!(:sentstatus =>{})
        params[:sentstatus].merge!(:claim_id => params[:claim_id], :from => "#{current_user.email}", :to => params[:email], 
          :subject => params[:subject], :message => params[:message], :customer_id => "#{current_user.id}", 
          :agent_id => "#{Agent.find_by_email(params[:email]).id}", :is_viewed => false)
        @sentstatus = Sentstatus.new(params[:sentstatus])
        if @sentstatus.save
          UserMailer.user_send_mail(params[:email],params[:subject],params[:message].gsub("\r\n","<br>").gsub(" ","&nbsp;"),current_user.email).deliver
          flash[:success] = "Mail sent successfully"
          redirect_to root_path
        else
          render 'send_mail'
        end
      else
        render 'send_mail'
      end
  end 

  def view_agents
    role = Role.find(session[:agent_role_id])
    @agents = role.users.paginate :page => params[:page]   
  end  

  def upload_claim_details
    @claim = Claim.find(current_user.claims.first.id)
    #@claim = current_user.claims.first
    if request.put?
      logger.info "======================"
      logger.info params[:policy_document]
      if !params[:policy_document].blank? and !params[:policy_worth].blank? and !params[:monthly_premium].blank?
        @claim.update_attributes(:policy_document => params[:policy_document],:damage_photo => params[:damage_photo],:policy_worth => params[:policy_worth],:monthly_premium => params[:monthly_premium])    
        flash[:success] = "Document Uploaded successfully"
        #redirect_to root_path
      else
        flash.now[:error] = "Policy document,Policy_worth and Monthly premium can't blank"
      end  
    end  
  end 

  

end
