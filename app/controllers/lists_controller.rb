class ListsController < ApplicationController

	def index 
		@lists = current_user.lists.order(params[:sort_by])
	end

	def new
		@list = current_user.lists.new
	end

	def create
		#@list = List.new(params[:list])
		@user = current_user
		@list = @user.lists.new(params[:list])

		if @list.save
			flash[:notice] = "#{@list.name} List Created"
			redirect_to @list
		else
			flash[:alert] = "Something went wrong. Try again"
			redirect_to new_list_path
		end
	end

	def show
		@list = current_user.lists.find_by_id(params[:id])
		if @list
			@tasks = Task.for_list(@list).sorted_by(params[:sort_by])
	 		@task = @list.tasks.new
	 	else
	 		flash[:alert] = "Oops. Looks like you're trying to access someone else's list."
			redirect_to lists_path 
		end
	end

	def edit
		@list = List.find(params[:id])
	end

	def update 
		@list = List.find(params[:id])
			if @list.save(params[:list])
				flash[:notice] = "List successfully updated"
				redirect_to @list
			else
				flash[:alert] = "Something went wrong. Try again"
				redirect_to edit_list_path(@list)
			end
	end

	def destroy
		@list = List.find(params[:id])
		if @list.destroy
			redirect_to lists_path
		end
	end

	def clear_completed
		@list = List.find(params[:id])
		if @list.tasks.complete.destroy_all
			flash[:notice] = "Completed tasks have been cleared"
			redirect_to @list
		end
	end

end
