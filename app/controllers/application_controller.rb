class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper

  private 
  
  def require_user_logged_in
    unless logged_in?
#      render login_path
      redirect_to login_url
    end
  end
  
  def counts(user)
    @count_tasks = user.tasks.count
  end
end
