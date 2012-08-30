# == Schema Information
#
# Table name: books
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Book < ActiveRecord::Base
  attr_accessible :title
  belongs_to :user

  validates :title,   presence: true, length: { maximum: 140 }
  validates :user_id, presence: true

  default_scope order: 'books.created_at DESC'
end
