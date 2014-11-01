class LibraryBookRenewalsController < ApplicationController
  def search_book
  end
  def renewal_book_search_result
  	@books=Book.where("(book_no=? OR barcode_no=?) AND status='borrowed'",get_book_barcode_no['bookno_barcode'],get_book_barcode_no['bookno_barcode'])
  end
  def renewal_book_form
  	@ib=IssueBook.find_by_book_id(params[:format])
  end
  def update_due_date

  	@ib=IssueBook.find(params[:id])
    @ib.status='renewal'
    if @ib.update(due_date_params)
      flash.now[:notice] = 'Book renewal successfully'
      render 'renewal_book_form'
    else
      flash.now[:notice] = 'Book renewal fail'
      render 'renewal_book_form'
    end
  end
  def movement_log_search_result
    if get_date_type_date['date_type']=='Issue date' 
      @ms=IssueBook.where("issue_date=?",get_date_type_date['date'])
    elsif get_date_type_date['date_type']=='Due date' 
      @ms=IssueBook.where("due_date=?",get_date_type_date['date'])
    end

  end
  private
  def get_book_barcode_no
  	params.require(:search).permit!
  end
  def due_date_params
    params.require(:issue_book).permit(:due_date,:status)
  end
  def get_date_type_date
    params.require(:msearch).permit!
  end
end
