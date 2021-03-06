# encoding: UTF-8
require 'spec_helper'

describe "Static pages" do

  subject { page }

  describe "Home page" do

    before { visit root_path }
    it { should have_selector('h1',    text: 'Barter Books') }
    it { should have_selector('title', text: full_title('')) }
    it { should_not have_selector 'title', text: '| Home' }
  end

  describe "Help page" do
    before { visit help_path }

    it { should have_selector('h1',    text: 'ヘルプ') }
    it { should have_selector('title', text: full_title('Help')) }
  end

  describe "About page" do
    before { visit about_path }

    it { should have_selector('h1',    text: 'About') }
    it { should have_selector('title', text: full_title('About Us')) }
  end

  describe "Contact page" do
    before { visit contact_path }

    it { should have_selector('h1',    text: 'Contact') }
    it { should have_selector('title', text: full_title('Contact')) }
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "Barter Booksについて"
    page.should have_selector 'title', text: full_title('About Us')
    click_link "ヘルプ"
    page.should have_selector 'title', text: full_title('Help')
    click_link "コンタクト"
    page.should have_selector 'title', text: full_title('Contact')
    click_link "ホーム"
    click_link "Barter Booksに登録する"
    page.should have_selector 'title', text: full_title('Sign up')
    click_link "サインイン"
    page.should have_selector 'title', text: full_title('')
  end
end
