# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


Create a new rails application with postgresql database

mkdir rails_applications
cd rails_applications

rails new demo_api --api --database=postgresql

cd demo_api

rails g migration add-customer-address-table

rails db # this command is used for the rails db open with sql

Why we used materialized view?

If you want to used the data from 5 different table with the help of join
5 differnt table having a huge amount of data


Materialized view:

create the cache amount of data in our disk

so rails manage through the disk, in rails we not stored the data in databse the data is available in disk, when the new row created or modified the disk will be manage.

when you hit the query and seach particular data, it is search from the disk not from the database

Drawback of materialized view:
Disk space

I have a 5 table, and each table contaion the 1 lakh data total amount of data 5 lakh in future it will be 10 lakh, 15 lakh

more amount of data insert than the disk space error occur disk overloaded

# create the materialized view
def up
end

# drop the materialized view
def down
end

== 20230215053123 AddCustomerDetailsMaterializedView: migrating ===============
-- execute("\n      CREATE MATERIALIZED VIEW customer_details AS\n        SELECT\n          customers.id as customer_id,\n          customers.first_name as first_name,\n          customers.last_name as last_name,\n          addresses.street as street,\n          addresses.city as city\n        FROM\n          customers\n        JOIN addresses ON\n          customers.id = addresses.customer_id\n    ")
   -> 0.0091s
-- execute("\n      CREATE UNIQUE INDEX\n        customer_details_customer_id\n      ON\n        customer_details(customer_id)\n    ")
   -> 0.0020s
== 20230215053123 AddCustomerDetailsMaterializedView: migrated (0.0113s) ======


insert into customers (first_name, last_name) values ('bhartee', 'sahare');
insert into addresses (customer_id, street, city) values (1, 'dabha', 'nagpur');

# this command is refresh the data of materialized view
REFRESH MATERIALIZED VIEW customer_details;



create a new rails app
rails new demo_app --api
cd demo_app
rails g scaffold user email:string password:string auth_token:string
rails g scaffold post title:string body:text user:references
rails g scaffold comment body:text user:references post:references
rake db:migrate

http://localhost:3000/users
=> []
http://localhost:3000/posts
=> []
http://localhost:3000/comments
=> []

in this file add this below code-> user.rb
has_many :posts
has_many :comments

in this file add this below code-> post.rb
has_many :comments

in the seeds.rb file add the below code.
u1 = User.create(email: 'user@example.com', password: 'password')
u2 = User.create(email: 'user2@example.com', password: 'password')

p1 = u1.posts.create(title: 'First Post', body: 'An Airplane')
p2 = u1.posts.create(title: 'Second Post', body: 'A Train')

p3 = u2.posts.create(title: 'Third Post', body: 'A Truck')
p4 = u2.posts.create(title: 'Fourth Post', body: 'A Boat')

p3.comments.create(body: "This post was terrible", user: u1)
p4.comments.create(body: "This post was the best thing in the whole world", user: u1)


than run the command rails db:create && rails db:migrate && rails db:seed


Now check this below url again we are reciving the data,
http://localhost:3000/users
http://localhost:3000/posts
http://localhost:3000/comments


We are moving add serialization:

gem 'active_model_serializers', '~> 0.8.3' this add the in gemfile
run bundle install

rails g serializer user # in console try this one.

user_serializer.rb
class UserSerializer < ActiveModel::Serializer
  attributes :id
end

when we hit the url:

{"users":[{"id":1},{"id":2},{"id":3},{"id":4},{"id":5},{"id":6},{"id":7},{"id":8},{"id":9},{"id":10}]}


rails g serializer post
rails g serializer comment

post_serializer.rb
