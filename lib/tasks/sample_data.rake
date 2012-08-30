namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Sachie Shinzato",
                         email: "e125723@ie.u-ryukyu.ac.jp",
                         password: "foobar",
                         password_confirmation: "foobar",
                         booklog_account: "snzt")
    admin.toggle!(:admin)
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@ie.u-ryukyu.ac.jp"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password,
                   booklog_account: "amothic" )
    end
  end
end
