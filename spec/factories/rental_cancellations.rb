FactoryBot.define do
  factory :rental_cancellation do
    user { nil }
    date { '2020-02-08' }
    description { 'MyString' }
    rental { nil }
    car_rental { nil }
  end
end
