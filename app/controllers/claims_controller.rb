class ClaimsController < ApplicationController
  # GET /claims
  handles_sortable_columns
  # GET /claims.json
  def index
    @claims = Claim.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @claims }
    end
  end

  # GET /claims/1
  # GET /claims/1.json
  def show
    @claim = Claim.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @claim }
    end
  end

  # GET /claims/new
  # GET /claims/new.json
  def new
    @claim = Claim.new
    # @claim.policy_photos.build


    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @claim }
    end
  end

  # GET /claims/1/edit
  def edit
    @claim = Claim.find(params[:id])
  end

  # POST /claims
  # POST /claims.json
  def create
    @claim = Claim.new(params[:claim])

    respond_to do |format|
      if @claim.save
        format.html { redirect_to @claim, notice: 'Claim was successfully created.' }
        format.json { render json: @claim, status: :created, location: @claim }
      else
        format.html { render action: "new" }
        format.json { render json: @claim.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /claims/1
  # PUT /claims/1.json
  def update
    @claim = Claim.find(params[:id])

    respond_to do |format|
      if @claim.update_attributes(params[:claim])
        format.html { redirect_to @claim, notice: 'Claim was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @claim.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /claims/1
  # DELETE /claims/1.json
  def destroy
    @claim = Claim.find(params[:id])
    @claim.destroy

    respond_to do |format|
      format.html { redirect_to claims_url }
      format.json { head :no_content }
    end
  end

  def enduser_listclaims
    # logger.warn("=========#{params[:userclaims]}===========")
    
    @claimparam = params[:userclaims]
     if @claimparam == "allclaims"
      @enduser_claims = current_user.claims
    elsif @claimparam == "inprocess"
      @users = User.joins(:claims).find(:all,:conditions => ["claim_status = ? and completed_status = ?",true,false])
      # current_user.user_claims.each do |claim|
      #   @claims = claim.user.where(:claim_status => true,:completed_status => false )
      # end
    elsif @claimparam == "completed"
      @users = User.find(:all,:conditions => ["claim_status =? and completed_status =?",true,true])
      # current_user.user_claims.each do |claim|
      #   @claims = claim.user.where(:claim_status => true,:completed_status => true )
      # end
    elsif @claimparam == "pending"
      @users = User.joins(:claims).find(:all,:conditions => ["claim_status = ?","pending"])
  end
        

  end

  def enduser_upload
    @claim = Claim.find(params[:id])

  end  

  def enduser_upload_update
    @claim = Claim.find(params[:id])
    respond_to do |format|
       # @claim.policy_photos.build 
    # if params[:claim][:policy_photos_attributes]
    #     @claim.policy_photos.build 
    # elsif params[:claim][:damage_photos_attributes]
    #     @claim.damage_photos.build 
    # end
      if @claim.update_attributes(params[:claim])
        format.html { redirect_to enduser_listclaims_path, notice: 'Claim was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "enduser_upload" }
        format.json { render json: @claim.errors, status: :unprocessable_entity }
      end
    end
  end 

  def change_status
    raise params.inspect
  end
  

end
