class FinesController < ApplicationController
  def library_fines

  end

  def detail_fine
       
      if params[:name].present?
  	   @student=Student.where("first_name LIKE '#{params[:name]}%' 
  	   	OR admission_no='#{params[:name]}'")
  	else
  		p "-----------"
  		startdate=params[:start_date].to_date
        enddate=params[:end_date].to_date
     
  		@student=[]
  		@fines=Fine.where(created_at:startdate..enddate)

  		@fines.each do |f|
  		p f.issue_book.student
  		end
     end
  end



   def delete_fine
   	@fine=Fine.find(params[:id])
   	@fine.destroy

   end


end
