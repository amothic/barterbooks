FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@ie.u-ryukyu.ac.jp"}   
    password "foobar"
    password_confirmation "foobar"
    booklog_account "amothic"

    factory :admin do
      admin true
    end
  end

  factory :book do
    title "Lorem ipsum"
    sequence(:booklog_id)  { |n| n }
    user
  end
end
