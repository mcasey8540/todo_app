class TasksController < ApplicationController

	before_filter :find_list, :only => [:create, :complete, :new, :edit, :update, :delete]
	respond_to :html, :xml, :js

	def create
		@task = @list.tasks.new(params[:task])

		if @task.save
			schedule_sms(@task)
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
			schedule_sms(@task)
			flash[:notice] = "#{@task.description} successfully updated"
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

	def schedule_sms(task)
		unless task.sms_reminder.nil? 
			d = task.due_at.to_s
			time = Time.new(d[0..3],d[5..6],d[8..9]) - (3600 * task.sms_reminder.to_i )
			@iw = IronWorkerNG::Client.new
			@iw.schedules.create("sms", 
											{
											description: task.description, 
											sms_reminder: task.sms_reminder, 
											due_at: task.due_at.to_date, 
											to: current_user.phone_number,
											},	
	                     {
	                         #This is the schedule
	                         :start_at => time,
	                         #:start_at => task.due_at - (3600 * task.sms_frequency.to_i),
	                         :run_times => 1,
	                         #:end_at => Time.now + 180
	                     })
		end
	end

end
