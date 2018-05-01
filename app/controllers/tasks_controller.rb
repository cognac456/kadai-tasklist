class TasksController < ApplicationController

def index
  @tasks=Task.all
end

def show
  @task=Task.find(params[:id])
end

def new
  @task= Task.new
end

def create
  @task =Task.new(task_params)
  if @task.save
    flash[:success]="正常に投稿"
    redirect_to @task
  else
    flash.now[:danger]="投稿できませんでした"
    render :new
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
  redirect_to @task
#  redirect_to tasks_url　 #これにしないといけない理由は？
end


private 

def task_params
  params.require(:task).permit(:content, :status)
end

end     #classのend