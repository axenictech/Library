class BarcodesController < ApplicationController

	def barcode_index
	end

	def manage_barcode
		if params[:search].eql? "book_number"
			@infos=Book.where("book_no='#{params[:value]}'")
		
		elsif params[:search].eql? "title"
			@infos=Book.where("title='#{params[:value]}'")
	    
	    elsif params[:search].eql? "author"
			@infos=Book.where("author='#{params[:value]}'")
	    
	    elsif params[:search].eql? "tag"
	    	@tag=Tag.find_by_name(params[:value])
           	@infos=@tag.books
	    end

	end

	def edit_barcode
		@barcode=Book.find(params[:barcode])
	end

	def update_barcode
		
		@barcode=params[:barcode]
		
		@barcode.each_pair do |k,v|
			book=Book.find(k)
			
			if book.update(barcode_no:v)
				flash.now[:notice]="Barcode Update Successfully"
			render 'barcode_index'	
		    else
		    	flash.now[:notice]="Barcode is not udate"
		    	render 'barcode_index'
		    end
		end
	end

end
