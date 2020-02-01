FactoryBot.define do
  sequence :code do |n|
    "BKING#{n}"
  end

  factory :rental do |n|
    code
    start_date { Date.current }
    end_date { 1.day.from_now }
    car_category
    user
    client
  end
end
