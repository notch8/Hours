# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :timer do
    project
    category
    user
    hour
    starts_at "2019-08-11 01:14:18"
    ends_at "2019-08-11 01:14:18"
    description "An Example Timer"
  end

  factory :new_timer, class: Timer do
    project
    category
    user
    starts_at "2019-08-11 01:14:18"
    description "An in-process timer"
  end
end
