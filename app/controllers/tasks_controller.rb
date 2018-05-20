class TasksController < ApplicationController

def index
  if logged_in?
    @tasks=current_user.tasks.all.page(params[:page]).per(10)
  end
end

def show
  @task=Task.find(params[:id])
end

def new
  @task= Task.new
end

def create
#  @task =Task.new(task_params)
#  @task.user_id = current_user.id
  @task =current_user.tasks.build(task_params)
  if @task.save
    flash[:success]="正常に投稿"
    redirect_to root_url
 else
    flash.now[:danger]="投稿できませんでした"
    @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
    render :index
  end
end

def edit
  @task =Task.find(params[:id])
end

def update
  @task= Task.find(params[:id])
  if @task.update(task_params)
    flash[:success]="更新成功"
    #redirect_to task_path(@task)
    redirect_to @task
  else
    flash[:danger]="更新失敗"
    render :edit
  end
end

def destroy
  @task=Task.find(params[:id])
  @task.destroy
  
  flash[:success] ="削除しました"
  redirect_to tasks_path
#  redirect_back(fallback_location: root_path)
end


private 

def task_params
  params.require(:task).permit(:content, :status)
end

def correct_user
  @task= current_user.tasks.find_by(id: params[:id])
  unless @task
    redirect_to root_url
  end
end

end     #classのend