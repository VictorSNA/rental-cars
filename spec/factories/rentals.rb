FactoryBot.define do
  sequence :code do |n|
    "BKING#{n.to_s.rjust(3, '0')}"
  end

  factory :rental do
    code
    start_date { Date.current }
    end_date { 1.day.from_now }
    car_category
    user
    client
    subsidiary
  end
end
