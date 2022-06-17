# THE BLOG
Requirements:
- Ruby on Rails 7
- Vuejs 3
- Mysql Server

## Project Structure
- api: present the backend logic.
  - app
    - controllers
    - channels: Realtime events stream.
    - services: isolated logical units deals with ActiveRecord Models.
    - presenters: handle the required format and data needed by the client.
    - models
    - docker: contains entry point script shell and Test database creation sql script.
- frontend: present the client application written in vuejs.
  - src
    - components
    - services: contains the blueprint of the restful api communication using Axios
    - store

# How to run it
- git clone git@github.com:Rudy-Zidan/blog.git
- cd blog
- docker compose up: this will setup the whole environment for all three main components(Api, Frontend, Mysql).
- hit the api server through the following url: "http://localhost:3000"
- open the client app through the following url: "http://localhost:8080"

## For clean start (Reset everything)
- docker compose down -v
- docker compose up

## Run Test
- docker exec -it blog_api rails db:migrate RAILS_ENV=test
- docker exec -it blog_api rails test

# API Docs
A postman collection exist in the root project dir. "Blog.postman_collection.json"
