class TasksController < ApplicationController

	respond_to :html, :xml, :js

	def create
		@list = List.find(params[:list_id])
		@task = @list.tasks.new(params[:task])
		if @task.save
			flash[:notice] = "Task create successful"
			redirect_to @list
		else
			flash[:notice] = "Task Create Unsuccessful"
			redirect_to @list
		end
	end

	def complete
		@list = List.find(params[:list_id])
		@task = @list.tasks.find(params[:id])
		@task.completed = true
		@task.save
			redirect_to @list
	end

end
