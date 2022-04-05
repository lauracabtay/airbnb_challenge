--Listing table
insert into listing (title, description, location, price_per_night)  values ('2 bed  apartment', 'Lorem ipsum dolor sit amet','London', 350.00);
insert into listing (title, description, location, price_per_night)  values ('Lovely studio in Camden Town', 'Lorem ipsum dolor sit amet.', 'London', 280.00);
insert into listing (title, description, location, price_per_night)  values ('Luxury apartment in Chelsea', 'Lorem ipsum dolor sit amet.', 'London', 600.00);

--Booking table
insert into booking (booking_date, property_id, booked_by, start_date, end_date, price, booking_status) values ('2022-04-04', 1, 1, '2022-04-07', '2022-04-10', 10
50.00, 1);
insert into booking (booking_date, property_id, booked_by, start_date, end_date, price, booking_status) values ('2022-04-04', 3, 2, '2022-04-04', '2022-04-11', 4200.00, -1);
insert into booking (booking_date, property_id, booked_by, start_date, end_date, price, booking_status) values ('2022-04-05', 2, 3, '2022-04-06', '2022-04-08', 560.00, 0);

--Calendar table
insert into calendar (property_id, is_available, date) values (1, TRUE, '2022-04-04');
insert into calendar (property_id, is_available, date) values (1, TRUE, '2022-04-05');
insert into calendar (property_id, is_available, date) values (1, TRUE, '2022-04-06');
insert into calendar (property_id, is_available, date) values (1, FALSE, '2022-04-07');
insert into calendar (property_id, is_available, date) values (1, FALSE, '2022-04-08');
insert into calendar (property_id, is_available, date) values (1, FALSE, '2022-04-09');
insert into calendar (property_id, is_available, date) values (1, TRUE, '2022-04-10');
insert into calendar (property_id, is_available, date) values (2, TRUE, '2022-04-04');
insert into calendar (property_id, is_available, date) values (2, TRUE, '2022-04-05');
insert into calendar (property_id, is_available, date) values (2, FALSE, '2022-04-06');
insert into calendar (property_id, is_available, date) values (2, FALSE, '2022-04-07');
insert into calendar (property_id, is_available, date) values (2, TRUE, '2022-04-08');
insert into calendar (property_id, is_available, date) values (2, TRUE, '2022-04-09');
insert into calendar (property_id, is_available, date) values (2, TRUE, '2022-04-10');
insert into calendar (property_id, is_available, date) values (3, TRUE, '2022-04-04');
insert into calendar (property_id, is_available, date) values (3, TRUE, '2022-04-05');
insert into calendar (property_id, is_available, date) values (3, TRUE, '2022-04-06');
insert into calendar (property_id, is_available, date) values (3, TRUE, '2022-04-07');
insert into calendar (property_id, is_available, date) values (3, TRUE, '2022-04-08');
insert into calendar (property_id, is_available, date) values (3, TRUE, '2022-04-09');
insert into calendar (property_id, is_available, date) values (3, TRUE, '2022-04-10');

--users table
insert into users (username, password) values ('test@example.com', 'Password1');
insert into users (username, password) values ('test2@example.com', 'Password2');
insert into users (username, password) values ('test3@example.com', 'Password3');

--host table
insert into hosts (user_id, listing_id) values (2, 1);
insert into hosts (user_id, listing_id) values (3, 2);
insert into hosts (user_id, listing_id) values (1, 3);








