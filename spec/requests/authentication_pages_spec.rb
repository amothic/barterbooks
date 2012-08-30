# encoding: UTF-8
require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_selector('h1',    text: 'サインイン') }
    it { should have_selector('title', text: 'Sign in') }
  end

  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "サインイン" }

      it { should have_selector('title', text: 'Sign in') }
      it { should have_selector('div.alert.alert-error', text: 'Invalid') }
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user }

      it { should have_selector('title', text: user.name) }

      it { should have_link('ユーザーを表示',    href: users_path) }
      it { should have_link('プロフィールを表示', href: user_path(user)) }
      it { should have_link('設定', href: edit_user_path(user)) }
      it { should have_link('サインアウト', href: signout_path) }

      it { should_not have_link('サインイン', href: signin_path) }

      describe "followed by signout" do
        before { click_link "サインアウト" }
        it { should have_link('サインイン') }
      end

      describe "create user" do
        before { visit signup_path }
        it { should_not have_selector('title', text: full_title('Sign up')) }
      end
    end
  end
  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "メールアドレス",    with: user.email
          fill_in "パスワード", with: user.password
          click_button "サインイン"
        end

        describe "after signing in" do

          it "should render the desired protected page" do
            page.should have_selector('title', text: 'Edit user')
          end
        end
      end

      describe "in the Users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_selector('title', text: 'Sign in') }
        end

        describe "submitting to the update action" do
          before { put user_path(user) }
          specify { response.should redirect_to(signin_path) }
        end
        describe "visiting the user index" do
          before { visit users_path }
          it { should have_selector('title', text: 'Sign in') }
        end
      end

      describe "in the Books controller" do

        describe "submitting to the create action" do
          before { post books_path }
          specify { response.should redirect_to(signin_path) }
        end

        describe "submitting to the destroy action" do
          before { delete book_path(FactoryGirl.create(:book)) }
          specify { response.should redirect_to(signin_path) }
        end
      end
    end

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@ie.u-ryukyu.ac.jp") }
      before { sign_in user }

      describe "visiting Users#edit page" do
        before { visit edit_user_path(wrong_user) }
        it { should_not have_selector('title', text: full_title('Edit user')) }
      end

      describe "submitting a PUT request to the Users#update action" do
        before { put user_path(wrong_user) }
        specify { response.should redirect_to(root_path) }
      end
    end

    describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before { sign_in non_admin }

      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete user_path(user) }
        specify { response.should redirect_to(root_path) }        
      end
    end
  end
end
