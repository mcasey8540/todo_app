class ListsController < ApplicationController

	respond_to :html, :xml, :js

	def index 
		@lists = List.all
	end

	def new
		@list = List.new
	end

	def create
		@list = List.new(params[:list])

		if @list.save
			flash.keep[:notice] = "List Created"
			redirect_to @list
		else
			flash.keep[:notice] = "Create unsuccessful. Try Again"
			redirect_to new_list_path
		end
	end

	def show
		@list = List.find(params[:id])
		@task = @list.tasks.new
		@priorities = ['low','high'] 
	end

	def edit
		@list = List.find(params[:id])
	end

	def update 
		@list = List.find(params[:id])
			if @list.update_attributes(params[:list])
				flash[:notice] = "Successfully updated"
				redirect_to @list
			else
				flash[:notice] = "Update unsuccessful"
				redirect_to edit_list_path(@list)
			end
	end

	def destroy
		@list = List.find(params[:id])
		if @list.destroy
			redirect_to lists_path
		end
	end


end
