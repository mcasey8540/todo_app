module ApplicationHelper

	def sortable(column, title = nil)
  	title ||= column.titleize

  	if column == "name"
  		direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
  	else 
  		direction = column == sort_column('tasks') && sort_direction == "asc" ? "desc" : "asc"
  	end
  	link_to title, {:sort => column, :direction => direction}
	end
	   
end
