# Immo Coin -- Back-end application

## About

### The app

ImmoCoin is a platform built with React and Rails where authenticated users can publish real estate classified ads. Only authenticated users can see contact details for an ad. Visitors and authenticated users can see the ads and search an ad by location. Authenticated users can create an ad and manage their published ads through a dashboard (edit the ad description and location, add pictures, delete the ad). Find the app in production on Heroku [here](https://thp-immo-proj.herokuapp.com/)!

### Technical specs

This Ruby on Rails app acts as a back-end server for a Next.js front-end app available [here](https://github.com/Caro407/THP_IMMO_PROJ_FRONT). It was built with Ruby 2.7.1 and Rails 6.1.3 in API mode, with a PostGreSQL database.
It provides an authentication system with the following gems:
* gem "devise"
* gem "devise-jwt"
* gem "rack-cors"

Other gems employed:

* gem "dotenv" and gem "dotenv-rails" for global variable management
* gem "faker" for database seeding
* gem "aws-sdk-s3" for image uploading and management through Active Storage and Amazon AWS3 storage service

## How to run locally

After cloning this repository (or downloading and unzipping it), run `bundle install` in the CLI to install necessary gems, and `rails db:create db:migrate db:seed` to set up the database. Create a `.env` file at the root of the directory and add a randomly generated DEVISE_JWT_SECRET_KEY secret key, which you can obtain by running `rake secret` in the CLI.

Run `rails server` to start the server on local port 3000.

## Team

* [Ariane](https://github.com/arejl)
* [Caroline](https://github.com/Caro407)
* [Emmanuel](https://github.com/EmmanuelQuere)
* [Erwann](https://github.com/erwannlenoach)