#listing_table
CREATE Table listing (id serial primary key, title varchar(60), description varchar(250), location varchar(120), price_per_night decimal(7,2));
#booking_table
Create Table booking (booking_id serial primary key, booking_date date, property_id
#calendar_table
Create Table calendar (id serial primary key, property_id integer, is_available boolean, date date);
#users
Create Table users (User_id serial primary key, username varchar(30), password varchar(10));
#hosts
Create Table hosts (Host_id serial primary key, user_id integer, listing_id integer);