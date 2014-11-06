class TagsController < ApplicationController

	def search_tags
		# unless params[:name].empty?
	   @tags=Tag.where("name like '#{params[:name]}%'")
	# end
	end

	def manage_tags
     @tags=Tag.where("name like '#{params[:name]}%'")
    end

	def delete_tag
		@tag=Tag.find(params[:id])
         @tag.destroy
         @tags=Tag.all
      end

     def edit_tag
     	@tag=Tag.find(params[:id])
     end

     def update_tag

     	@tag=Tag.find(params[:id])
     	@tag.update(get_tag)
     	@tags=Tag.all
     end

     def tag_related_book
     	@tag=Tag.find(params[:id])

     	@books=@tag.books


     end


     private 
     def get_tag
     	params.require(:tag).permit!
     end
end
