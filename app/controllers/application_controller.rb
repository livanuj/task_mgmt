class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def check_loggedin
    return true if current_user.present?

    redirect_to login_path, notice: "You need to signed in to perform this action"
  end
end
