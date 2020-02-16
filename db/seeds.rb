# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

sub_seed = Subsidiary.create!(name: 'Jundiaí 21', cnpj: '09.612.834/0001-22',
                              address: 'Avenida 9 de Julho, 2000')
other_sub = Subsidiary.create!(name: 'Paraíso 202', cnpj: '57.952.836/0001-03',
                               address: 'Avenida Paraíso, 202')
user_seed = User.create!(email: 'employee@gmail.com', password: '123456',
                         subsidiary: sub_seed, status: :employee)
User.create!(email: 'admin@gmail.com', password: '123456', subsidiary: sub_seed,
             status: :admin)
manu_seed = Manufacturer.create!(name: 'Suzuki')
car_cat_seed =CarCategory.create!(name: 'XYZ', daily_rate: 15.533, 
                                  car_insurance: 34.321,
                                  third_party_insurance: 33.922)
car_mod_seed = CarModel.create!(name: 'SuperCarro', year: '2020',
                                 manufacturer: manu_seed, motorization: '2.0',
                                 car_category: car_cat_seed,fuel_type: 'Flex')
cli_seed = Client.create!(name: 'Josésclayton', cpf: '523.476.268-84',
                          email: 'jclay@gmail.com')
Car.create!(license_plate: 'XYZ9999', color: 'Branco', car_model: car_mod_seed,
            mileage: 100, status: 0)
Rental.create!(code: 'COD123', start_date: Date.current,
               end_date: 1.day.from_now, client: cli_seed,
               car_category: car_cat_seed, user: user_seed,
               subsidiary: other_sub)
