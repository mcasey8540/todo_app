class TasksController < ApplicationController

	respond_to :html, :xml, :js

	def create
		@list = List.find(params[:list_id])
		@task = @list.tasks.new(params[:task])
		if @task.save
			flash[:notice] = "#{@task.description} has been successfully added"
			redirect_to @list
		else
			flash[:alert] = "Something went wrong. Try again"
			redirect_to @list
		end
	end

	def complete
		@list = List.find(params[:list_id])
		@task = @list.tasks.find(params[:id])
		@task.completed = true
		if @task.save
			flash[:notice] = "Congrats! #{@task.description} has been completed"
			redirect_to @list
		else
			flash[:alert] = "Something went wrong. Try again"
			redirect_to @list
		end
	end

	def edit
		@list = List.find(params[:list_id])
		@task = @list.tasks.find(params[:id])
	end

	def update
		@list = List.find(params[:list_id])
		@task = @list.tasks.find(params[:id])
		if @task.update_attributes(params[:task])
			flash[:notice] = "Item successfully updated"
			redirect_to @list
		else 
			flash[:alert] = "Something went wrong. Try again"
			redirect_to @list
		end
	end

	def delete
		@list = List.find(params[:list_id])
		@task = Task.find(params[:id])
		if @task.destroy
			flash[:notice] = "Task has been successfully deleted"
			redirect_to @list
		else
			flash[:alert] = "Something went wrong. Try again"
			redirect_to @list
		end
	end

	def sort
		@list = List.find(params[:id])
		@tasks = @list.tasks.select {|a| a.priority == 'high'}
	end
end
