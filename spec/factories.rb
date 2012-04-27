# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do |user|
    user.name                  "Michael Hartl"
    user.email                 "mhartl@example.com"
    user.password              "foobar"
    user.password_confirmation "foobar"
  end
end

FactoryGirl.define do
  sequence :email do |n|
    "person-#{n}@example.com"
  end
end

FactoryGirl.define do
  factory :micropost do |micropost|
    micropost.content "Foo bar"
    micropost.association :user
  end
end
