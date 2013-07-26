class EndUsersController < ApplicationController
  load_and_authorize_resource
  skip_authorization_check :only => [:register]
  def register
  	@end_user= EndUser.new(params[:end_user])
    if request.post?
      if @end_user.save
        redirect_to root_path , :notice => "User Registered successfully"
      end 
    end		
  end

  def enduser_listclaims
    @user = Customer.find(current_user.id)
    # raise @user.inspect
    @claims = @user.claims
    
    # @claimparam = params[:userclaims]
    #  if @claimparam == "allclaims"
    #   @enduser_claims = current_user.claims
    # elsif @claimparam == "inprocess"
    #   @users = User.joins(:claims).find(:all,:conditions => ["claim_status = ? and completed_status = ?",true,false])
    #   # current_user.user_claims.each do |claim|
    #   #   @claims = claim.user.where(:claim_status => true,:completed_status => false )
    #   # end
    # elsif @claimparam == "completed"
    #   @users = User.find(:all,:conditions => ["claim_status =? and completed_status =?",true,true])
    #   # current_user.user_claims.each do |claim|
    #   #   @claims = claim.user.where(:claim_status => true,:completed_status => true )
    #   # end
    # elsif @claimparam == "pending"
    #   @users = User.joins(:claims).find(:all,:conditions => ["claim_status = ?","pending"])
    # end
  end

  def claim_status
    @user = Customer.find(current_user)
  end 
end
