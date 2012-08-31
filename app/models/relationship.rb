# == Schema Information
#
# Table name: relationships
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  book_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Relationship < ActiveRecord::Base
  attr_accessible :book_id

  belongs_to :user_id, class_name: "User" 
  belongs_to :book_id, class_name: "Book"

  validates :user_id, presence: true
  validates :book_id, presence: true

end
