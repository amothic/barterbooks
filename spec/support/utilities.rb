# encoding: UTF-8
include ApplicationHelper

def sign_in(user)
  visit signin_path
  fill_in "メールアドレス",    with: user.email
  fill_in "パスワード", with: user.password
  click_button "サインイン"
  # Sign in when not using Capybara as well.
  cookies[:remember_token] = user.remember_token
end
