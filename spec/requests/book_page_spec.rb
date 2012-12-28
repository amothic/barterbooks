require 'spec_helper'

describe "Book pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "Book Loading" do
    before { visit root_path }

    describe "with valid information" do

      it "should loading a books" do
        expect { click_button "本を読み込む" }.should change(Book, :count)
      end
    end
  end
end
