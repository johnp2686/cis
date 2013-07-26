class ApplicationController < ActionController::Base
  protect_from_forgery
  # before_filter :set_current_user1

  # check_authorization :unless => :devise_controller?
  # load_and_authorize_resource
  # helper_method :current_user
  def set_current_user
    EndUser.current_user = current_user
  end
  
  # def set_current_user1
  #   User.current = current_user
  # end
  
end
