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

require 'spec_helper'

describe Book do
  let(:user) { FactoryGirl.create(:user) }
  before { @book = user.books.build(title: "Lorem ipsum", booklog_id: '2000') }

  subject { @book }

  it { should respond_to(:title) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  it { should respond_to(:booklog_id) }
  its(:user) { should == user }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Book.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end

  describe "when user_id is not present" do
    before { @book.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank title" do
    before { @book.title = " " }
    it { should_not be_valid }
  end

  describe "with title that is too long" do
    before { @book.title = "a" * 201 }
    it { should_not be_valid }
  end
end
