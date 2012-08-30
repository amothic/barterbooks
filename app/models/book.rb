# == Schema Information
#
# Table name: books
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  image_url  :string(255)
#  booklog_id :integer
#

class Book < ActiveRecord::Base
  attr_accessible :title, :image_url, :booklog_id
  belongs_to :user

  validates :title,      presence: true, length: { maximum: 140 }
  validates :user_id,    presence: true
  validates :booklog_id, presence: true,
                         uniqueness: true

  default_scope order: 'books.created_at DESC'
end
