class ListsController < ApplicationController

	def index 
		@lists = List.all
	end

	def new
		@list = List.new
	end

	def create
		@list = List.new(params[:list])

		if @list.save
			flash[:notice] = "#{@list.name} List Created"
			redirect_to @list
		else
			flash[:alert] = "Something went wrong. Try again"
			redirect_to new_list_path
		end
	end

	def show
		@list = List.find(params[:id])
		@tasks = Task.for_list(@list).sorted_by(params[:sort_by])
  	@task = @list.tasks.new
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
