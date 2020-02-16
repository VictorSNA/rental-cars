FactoryBot.define do
  sequence :email do |n|
    "teste#{n.to_s.rjust(3, '0')}@gmail.com"
  end
  factory :user do
    email
    password { '123456' }
    subsidiary
  end
end
