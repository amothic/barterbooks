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
end
