class LibraryManagementController < ApplicationController
  def library_dashboard
  	
  end
   #-----------------------------Manage Books---------------------------------------------------
  def books
    @books = Book.all
    
  end

  def add_books
    @book = Book.new

    if Book.first.nil?
       @book.book_no=111
    else
      @last_book=Book.last
      @book.book_no=@last_book.book_no.next
    end   

  end
  
  def save_new_book
    if params[:type]=='1'

      @cust_tag= params["cust_tag"]
     
      unless params["cust_tag"][0].nil?
      @cust_tag_tmp=Tag.create(name: @cust_tag)
      end
      if params[:no_of_cpoies].to_i<1.to_i
       flash[:alert]="Number of copies can not be less than one"
       @book = Book.new
       render library_management_addbooks_path
      else


      params[:no_of_cpoies].to_i.times do |i|
 
        @book = Book.new
        @book.book_no = params["book"]["book_no"].to_i+i
        @book.title =params["book"]["title"]
        @book.author=params["book"]["author"]
        @book.status="Available"
       if @book.save
         begin

          params["tag_ids"].each do |k|
          @book.books_tag.create(book_id:params["book_id"],tags_id: k)
        end # end of do

        rescue Exception => e
        end # end of begin

        @cust_tag= params["cust_tag"]
      unless params["cust_tag"][0].nil?
          @book.books_tag.create(book_id: @book.id,tags_id: @cust_tag_tmp.id)
      end 
    else 
      @error=true
    end
         
        
      end
       if @error

          render library_management_addbooks_path

        else 

          redirect_to library_management_books_path
         
          
       end
      end
    else 

      @cust_tag= params["cust_tag"]
       unless params["cust_tag"][0].nil?
      @cust_tag_tmp=Tag.create(name: @cust_tag)
      end

        @book = Book.new
        @book.barcode_no = params["book"]["barcode_no"].to_i
        @book.book_no = params["book"]["book_no"].to_i
        @book.title =params["book"]["title"]
        @book.author=params["book"]["author"]
        @book.status="Available"
        @book.save
     
        begin
          params["tag_ids"].each do |k|
          @book.books_tag.create(book_id:params["book_id"],tags_id: k)
        end
         rescue Exception => e
         end
        @cust_tag= params["cust_tag"]
      unless params["cust_tag"][0].nil?
          @book.books_tag.create(book_id: @book.id,tags_id: @cust_tag_tmp.id)
      end 

          redirect_to library_management_books_path(@book)
    end

  end

  def books_sorted_list
  @books_filter = get_fiterby_status_book['All']

  @books=Book.where("status = ?",get_fiterby_status_book['All'])  

   end


  def view_selected_book

    @book=Book.find(params[:id])

  end

  def search_books
  	
  end

  def search_books_list_result

    @book_search_field = get_book_list_for_search["search_field"]
    
    @book_search_choice = get_book_list_for_search["search_choice"]
   

    if @book_search_choice=="Book Number"

        @books=Book.where("book_no=?",@book_search_field)
    elsif @book_search_choice=="Barcode"
        @books=Book.where("barcode_no=?",@book_search_field)
    elsif @book_search_choice=="Title"
        @books=Book.where("title=?",@book_search_field)
    elsif  @book_search_choice=="Tag"
        @books=Book.where(id: BooksTag.where(id: Tag.where(name: @book_search_field).take).pluck(:book_id))
       
    else @book_search_choice=="Author"
        @books=Book.where("author=?",@book_search_field)
    end

  end

  def reserve_book
   

   @book = Book.where("id = ? AND status = 'Available'",params[:book_id]).take
   @book.update(status: 'Reserved')


  end

  def edit_book
    @book = Book.find(params[:id])
  end
  def update_book
     @book = Book.find(params[:id])

      @cust_tag= params["cust_tag"][0]
      unless @cust_tag.nil?
        Tag.create(name: @cust_tag)
      end
     
        @book.update(barcode_no: params["book"]["barcode_no"].to_i,book_no: params["book"]["book_no"].to_i,title: params["book"]["title"],author: params["book"]["author"],status: params["book"]["status"])
        
        @book.books_tag.each do |books_tag|
          books_tag.destroy
        end
        begin
        params["tag_ids"].each do |k|
          @book.books_tag.create(book_id:params["book_id"],tags_id: k)
        end
        rescue Exception => e
         end

        @cust_tag= params["cust_tag"][0]
        unless params["cust_tag"][0]==""
        @cust_tag_tmp=Tag.create(name: @cust_tag)
        @book.books_tag.create(book_id: @book.id,tags_id: @cust_tag_tmp.id)
        end
       redirect_to library_management_books_path(@book)
 end

 def delete_book
  @book=Book.find(params[:id])
     @book.books_tag.each do |books_tag|
          books_tag.destroy
        end
         @book.destroy
         redirect_to library_management_books_path(@book)
 end
 
  #---------------------------------------------------------------------------------------------
  def return_books
  	
  end
  
  def library_card_settings
  	
  end
  def manage_barcodes
  	
  end
  def movement_log
  	
  end
  def book_renewal
  	
  end
 
  def library_fines
  	
  end
  def manage_tags
  	
  end

#issue Book Actions
  def issue_books

        @book=Book.where("book_no = ? AND (status = 'Available' OR status='Reserved')",params["issue_book"]['book_no']).take   
        if params["issue_book"]['student_employee_id']=="" && params["issue_book"]['student_employee_id']==""
        flash[:alert]="Please Select Student or Employee"
        @book=Book.where(book_no: params["issue_book"]['book_no']).take
        @issue_book=IssueBook.new
        redirect_to library_management_book_issue_select_student_employee_path(@book.book_no)
    
        elsif @book.nil?
        flash[:alert]="Book Alredy Issued"
        @book=Book.where(book_no: params["issue_book"]['book_no']).take
        @issue_book=IssueBook.new
        redirect_to library_management_book_issue_select_student_employee_path(@book.book_no)
    
        else

         @issue_book=IssueBook.new
         @issue_book.book=@book
         unless d=Date.parse(params["issue_book"]['issue_date'])
         unless d2=Date.parse(params["issue_book"]['due_date'])
        @issue_book=IssueBook.new
        flash[:alert]="Due/Issue date not in correct format"
        redirect_to  library_management_book_issue_select_student_employee_path(@book,@issue_book)     
        end
         end

         @issue_book.issue_date=params["issue_book"]['issue_date']
         @issue_book.due_date=params["issue_book"]['due_date']
         @issue_book.status="Borrowed"
          if params["issue_book"]['is_student']=="Student"
             student=@issue_book.student=Student.where(id: params["issue_book"]['student_employee_id']).take
          else
             @issue_book.employee=Employee.where(id: params["issue_book"]['student_employee_id']).take
          end
        begin
         if @issue_book.save
          @message="Book has been issued "
          @book.update(status: "Borrowed")
          end
          redirect_to library_management_search_book_for_issue_path(@message)
        rescue Exception =>e
        @issue_book=IssueBook.new
        redirect_to  library_management_book_issue_select_student_employee_path(@book,@issue_book)     
        flash[:alert]="Please Select Student/Employee"
        end
      end
  end
  def search_book_for_issue
  	
  end
  def book_issue_select_student_employee
  	@book=Book.where(book_no: params["id"]).take
  	@issue_book=IssueBook.new
  end

  def search_book_for_issue_result
  	@book_no=get_book_no_for_search['bookno_barcode']
   	@books=Book.where("(book_no = ? OR barcode_no = ?) AND (status = 'Available' OR status='Reserved')", get_book_no_for_search['bookno_barcode'], get_book_no_for_search['bookno_barcode'])   
  end
  def student_employee_list
  begin
    @book=Book.where(id: params["search"]['book_id']).take
  if params["search"]['filter']=="Student"
  	@student=Student.where(admission_no: params["search"]['id']).take
  else
  	@employee=Employee.where(employee_number: params["search"]['id']).take
  	
  end
  
  rescue Exception =>e
    p e
  end
  end

  def get_book_details
  @book=Book.where(id: params["book_id"]).take
 
  begin
  if params["is_student"]=="Student"
  begin
  @student=Student.where(id: params['id']).take
  @no_of_books_to_issue=LibraryCardSetting.where(course_id:@student.batch.course_id,category_id: @student.category_id).take.books_issuable
  @no_of_books_issued=IssueBook.where(student_id: Student.where(batch_id: Batch.where(course_id: @student.batch.course_id),category_id: @student.category_id)).count 
  rescue Exception => e
  end
  	@student=Student.where(id: params['id']).take
  	@books_taken=IssueBook.where("student_id=? and status='Borrowed'",@student.id)
  else
  	@employee=Employee.where(id: params['id']).take
  	@books_taken=IssueBook.where("employee_id=? and status='Borrowed'",@employee.id)
  end
  
  rescue Exception =>e
  end

  end

  
  def search_book_for_return_result
    @book_no=get_book_no_for_search['bookno_barcode']
    @books=Book.where("(book_no = ? OR barcode_no = ?) AND (status = 'Borrowed')", get_book_no_for_search['bookno_barcode'], get_book_no_for_search['bookno_barcode'])   
  end
  def search_book_for_return
    
  end
  def process_return_book
     @book=IssueBook.where("book_id = ? AND status='Borrowed'", params['id']).take   
  end
  def return_books
    begin
   @book=IssueBook.where("id = ? AND status='Borrowed'",params["returnbook"]["book_id"]).take   
   if @book.due_date >=Date.today
   @book.update(status: "Available",returned_date: Date.today)
   @book.book.update(status: "Available")
   @message="Book has been returned "
   redirect_to library_management_search_book_for_return_path(@message)
   else
   
   @book.update(status: "Available",returned_date: Date.today)
   @book.book.update(status: "Available")
   @message="Book has been returned "
   Fine.create(issue_book_id: @book.id,amount: params["returnbook"]["amount"])
   redirect_to library_management_search_book_for_return_path(@message)

   end 
   rescue Exception=> e
    @message="Book Alredy returned "
    redirect_to library_management_search_book_for_return_path(@message)
   end
  end


  
  def library_card_setting_show
  end

  def library_get_library_card_setting
    #  @cource_choice = get_library_card_setting_choice["course_id"]
    # p @cource_choice
     p "----------------------------"
    p params[:cources_id]
    @cource= Course.find(params[:cources_id])
    @librarycards  = LibraryCardSetting.where(course_id: params[:cources_id])
  end

  def library_card_new
    @cource= Course.find(params[:id])
    @librarycard = LibraryCardSetting.new


  end

  def library_card_setting_add
    @cource= Course.find(params[:card_add][:course_id])
    @librarycard=  @cource.library_card_setting.create(params.require(:card_add).permit!)
     @librarycards =LibraryCardSetting.where(course_id: params[:card_add][:course_id])
    
  end

  def library_card_setting_edit  
    @librarycard =LibraryCardSetting.find(params[:id])
  
    end

   def library_card_setting_update
    @librarycard =LibraryCardSetting.where(id: params[:id]).take
    @librarycard.update(params.require(:card_add).permit!)
    @librarycards =LibraryCardSetting.where(course_id: params[:card_add][:course_id])

  end

  def library_card_setting_delete
    @librarycards =LibraryCardSetting.where(id: params[:id]).take
    @librarycard =LibraryCardSetting.where(id: params[:id]).take
    course_id=@librarycard.course.id
    @librarycards.destroy
    @librarycards =LibraryCardSetting.where(course_id: course_id)        
  end

  def library_fine_per_day_new

    @fineperday = PerDayFineDetail.new

  end

  def library_fine_per_day_add

    
    @fineperday = PerDayFineDetail.new(params.require(:add_fine).permit!)
    @fineperday.save
      
  end

  def manage_additional_details
    
  end
  def book_additional_details
  
  additional_details= BookMoreDetail.create()
  

  end


#Ravikiran Code From here


  def search_book
  end
  def renewal_book_search_result
    @books=Book.where("(book_no=? OR barcode_no=?) AND status='borrowed'",get_book_barcode_no['bookno_barcode'],get_book_barcode_no['bookno_barcode'])
  end
  def renewal_book_form
    @issue_book=IssueBook.find_by_book_id(params[:format])
  end
  def update_due_date

    @issue_book=IssueBook.find(params[:id])
    @issue_book.status='renewal'
    if @issue_book.update(due_date_params)
      flash.now[:notice] = 'Book renewal successfully'
      render 'renewal_book_form'
    else
      flash.now[:notice] = 'Book renewal fail'
      render 'renewal_book_form'
    end
  end
  def movement_log_search_result
    if get_date_type_date['date_type']=='Issue date' 
      @issue_book_dates=IssueBook.where("issue_date=?",get_date_type_date['date'])
    elsif get_date_type_date['date_type']=='Due date' 
      @issue_book_dates=IssueBook.where("due_date=?",get_date_type_date['date'])
    end
  end



#Sayali Code From Here


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





def library_fines

  end

  def detail_fine
       
    if params[:name].present?
       @student=Student.where("first_name LIKE '#{params[:name]}%' 
        OR admission_no='#{params[:name]}%'")
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
          flash.now[:notice]="Barcode is not udate"
      end
    end
       redirect_to library_management_barcode_index_path
  end















 private
 def get_book_no_for_search
 	params.require(:search).permit!
 end

def books_params
  params.require(:book).permit!
 end

 def tags_params
  params.require(:tag).permit!
 end


 def get_fiterby_status_book
  params.require(:sort_by).permit!
end

def get_book_list_for_search
  params.require(:search_book).permit!
end

def get_library_card_setting_choice
    params.require(:search_library_setting).permit!
end
end

#Ravikiran Parameters
 def get_book_barcode_no
    params.require(:search).permit!
  end
  def due_date_params
    params.require(:issue_book).permit(:due_date,:status)
  end
  def get_date_type_date
    params.require(:msearch).permit!
  end
#Sayali Parameters From Here
 def get_tag
      params.require(:tag).permit!
     end