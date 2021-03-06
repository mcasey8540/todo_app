class ListsController < ApplicationController

	helper_method :sort_column, :sort_direction
	respond_to :html, :json

	def index 
		@lists = current_user.lists.order(sort_column + " " + sort_direction)
	end

	def new
		@list = current_user.lists.new
	end

	def create
		@user = current_user
		@list = @user.lists.new(params[:list])

		if @list.save
			flash[:notice] = "#{@list.name} has been created. Go ahead and add some tasks!"
			redirect_to @list
		else
			flash[:alert] = "Something went wrong. Try again"
			redirect_to new_list_path
		end
	end

	def show
		@list = current_user.lists.find_by_id(params[:id])
		if @list
			@tasks = Task.for_list(@list).order(sort_column('tasks') + " " + sort_direction)
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
		respond_to do |format|
			if @list.update_attributes(params[:list])
				format.html { redirect_to(@list, :notice => 'User was successfully updated.')}
				format.json { respond_with_bip(@list) }
	    else
	      format.html { render :action => "edit" }
	      format.json { respond_with_bip(@list) }
	    end
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
		if @list.tasks.where(:completed => true).destroy_all
			flash[:notice] = "Completed tasks have been cleared"
			redirect_to @list
		end
	end

	private 

	def sort_column(type=nil)
    if type == 'tasks'
    	Task.column_names.include?(params[:sort]) ? params[:sort] : "description"
    else 
    	List.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
