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
		 error=false
		@barcode=params[:barcode]
		
		@barcode.each_pair do |k,v|
			book=Book.find(k)
			
			unless book.update(barcode_no:v)
				error=true
			 end

			if error==true
				render 'manage_barcode'
			else 
				flash[:notice]="Barcode Update Successfully"
		   
		    end
			end
			redirect_to  barcodes_barcode_index_path
	end

end
