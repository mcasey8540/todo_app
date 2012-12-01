class TasksController < ApplicationController

	before_filter :find_list, :only => [:create, :complete, :new, :edit, :update, :delete]
	respond_to :html, :xml, :js

	def create
		@task = @list.tasks.new(params[:task])

		if @task.save
			Task.schedule_sms(@task, current_user)
			flash[:notice] = "Yay, #{@task.description} has been added. Now get working!"
			redirect_to @list
		else
			flash[:alert] = "Something went wrong. Try again"
			redirect_to @list
		end
	end

	def complete
		Task.complete_task(params[:id])
		redirect_to @list
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
			 Task.cancel_sms_reminder(@task,current_user)
			 Task.schedule_sms(@task, current_user)
			flash[:notice] = "#{@task.description} successfully updated"
			redirect_to @list
		else
			flash[:alert] = "Something went wrong. Try again"
			redirect_to @list
		end
	end

	def delete
		@task = Task.find(params[:id])
		Task.cancel_sms_reminder(@task,current_user)
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
