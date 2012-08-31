class BooksController < ApplicationController
  before_filter :signed_in_user
  helper_method :create

  def create
    require 'net/http'
    book_info = Net::HTTP.start('api.booklog.jp',80) {|http| http.get('/json/' + current_user.booklog_account + '?category=0&count=500')}
    book_info_hash = ActiveSupport::JSON.decode(book_info.body)
    book_info_hash['books'].each do | book |
      if book.include?('title')
        @book = current_user.books.build(title: book['title'], image_url: book['image'], booklog_id: book['id'])
        @book.save
      end
    end
    redirect_to root_url
  end

  def destroy
  end

end
