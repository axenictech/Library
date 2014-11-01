class FinesController < ApplicationController
  def library_fines

  end

  def detail_fine
       
    if params[:name].present?
  	   @student=Student.where("first_name LIKE '#{params[:name]}%' 
  	   	OR admission_no='#{params[:name]}'")
  	else
  		p "-----------"
  		startdate=params[:start_date]
        enddate=params[:end_date]
     
  		@student=[]
  		@fines=Fine.where(created_at:startdate..enddate)
 
     unless @fines.nil?
  		 @fines.each do |f|
        unless f.issue_book.nil?
    		 @student<<f.issue_book.student
  		  end
       end
  		end
     end
  end



   def delete_fine
   	@fine=Fine.find(params[:id])
   	@fine.destroy

   end


end
