class ToppagesController < ApplicationController
  def index
    if logged_in?
      @user= current_user
      @task= current_user.tasks.build #空のインスタンス
      @tasks= current_user.tasks.order('created_at DESC').page(params[:page])
#    @tasks=Task.all.page(params[:page]).per(10)
    end
  end
end
