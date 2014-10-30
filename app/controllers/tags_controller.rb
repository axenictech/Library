class TagsController < ApplicationController

	def manage_tag
	@tags = Tag.search(params[:search])
   @tags=Tag.all
	end
end
