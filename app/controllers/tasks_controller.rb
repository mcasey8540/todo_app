class TasksController < ApplicationController

	before_filter :find_list, :only => [:create, :complete, :new, :edit, :update, :delete]

	respond_to :html, :xml, :js

	def create
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
		@task = @list.tasks.find(params[:id])
		if @task.completed == false
			@task.completed = "true"
			if @task.save
				flash[:notice] = "Congrats! #{@task.description} has been completed"
				redirect_to @list
			else
				flash[:alert] = "Something went wrong. Try again"
				redirect_to @list
			end
		else
			@task.completed = false
			if @task.save
				flash[:notice] = "#{@task.description} has been changed to incomplete"
				redirect_to @list
			else
				flash[:alert] = "Something went wrong. Try again"
				redirect_to @list
			end
		end
	end

	def new
		@task = @list.tasks.new(params[:task])
	end

	def edit
		@task = @list.tasks.find(params[:id])
	end

	def update
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
		@task = Task.find(params[:id])
		if @task.destroy
			flash[:notice] = "#{@task.description} has been successfully deleted"
			redirect_to @list
		else
			flash[:alert] = "Something went wrong. Try again"
			redirect_to @list
		end
	end

private
	
	def find_list
		@list = List.find(params[:list_id])
	end

end
