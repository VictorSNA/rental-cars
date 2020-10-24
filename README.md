# Rental Cars

Rental Cars is a project for renting cars through the administrative system.
It's focus is to manage cars, clientes and units of business.

## Getting Started

To execute you need to clone in your local machine. It's compatible with ruby
2.6.3, if you prefer you can install in your computer, after that you can
install dependencies by running `bundle install`.

You can either use docker to do all you need, you just need to run
`./bin/rental-cars prepare`. Tested with docker `19.03.8` and docker-compose
`1.26.2`.

## Executing tests

To run tests if you're using docker, you can execute `./bin/rental-cars rspec`
or to run in your machine `bundle exec rspec`.
