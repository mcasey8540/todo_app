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

	def edit
		@list = List.find(params[:list_id])
		@task = @list.tasks.find(params[:id])
	end

	def update
		@list = List.find(params[:list_id])
		@task = @list.tasks.find(params[:id])
		if @task.update_attributes(params[:task])
			redirect_to @list
		else 
			flash[:notice] = "Task Edit Unsuccessful"
			redirect_to edit_list_task
		end
	end

	def sort
		@list = List.find(params[:id])
		@task = @list.tasks.select! {|task| task.priority == 'high'}
			redirect_to @list
	end
end
