class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @book = current_user.books.build
      @feed_items = current_user.books.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end

  def contact
  end

  def search
    if !params[:title].blank?
      @feed_items = Book.where(["title LIKE ?", "%#{params[:title]}%"]).paginate(page: params[:page]) if params[:title].present?
    else
      @feed_items = Book.paginate(page: params[:page])
    end
  end
        
end
