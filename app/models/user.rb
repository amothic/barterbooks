# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean          default(FALSE)
#  booklog_account :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :booklog_account
  has_secure_password
  has_many :books, dependent: :destroy
  has_many :relationships, foreign_key: "user_id", dependent: :destroy
  has_many :borrowed_books, through: :relationships, source: :book_id

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  validates :name,  presence: true, length: { maximum: 50 }
  validates :email, presence: true, 
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  validates :booklog_account,  presence: true, length: { maximum: 50 }

  def borrowing?(book)
    relationships.find_by_book_id(book.id)
  end

  def borrow!(book)
    relationships.create!(book_id: book.id)
  end

  def return!(book)
    relationships.find_by_book_id(book.id).destroy
  end
  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
