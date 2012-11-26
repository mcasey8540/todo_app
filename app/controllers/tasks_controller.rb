class TasksController < ApplicationController

	before_filter :find_list, :only => [:create, :complete, :new, :edit, :update, :delete]

	respond_to :html, :xml, :js

	def create
		@task = @list.tasks.new(params[:task])

		if @task.save
			schedule_sms(@task.sms_frequency)
			flash[:notice] = "Yay, #{@task.description} has been added. Now get working!"
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
				flash[:notice] = "Congrats! You've completed #{@task.description}. You should be proud!"
				redirect_to @list
			else
				flash[:alert] = "Something went wrong. Try again"
				redirect_to @list
			end
		else
			@task.completed = false
			if @task.save
				flash[:notice] = "Looks like #{@task.description} hasn't been completed. Get crackin!"
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

	def schedule_sms(sms_frequency)
		@iw = IronWorkerNG::Client.new
		@iw.schedules.create("sms",
                     @config,
                     {
                         #This is the schedule
                         :start_at => Time.now,
                         :run_every => sms_frequency.to_i * 60
                     })
	end

end
