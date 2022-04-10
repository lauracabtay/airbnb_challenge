--listing_table
CREATE TABLE listing (
    id SERIAL PRIMARY KEY,
    title VARCHAR(60),
    description VARCHAR(250),
    location VARCHAR(120),
    price_per_night DECIMAL(7, 2),
    host_id INTEGER,
    CONSTRAINT fk_host_id FOREIGN KEY(host_id) REFERENCES users(user_id)
);
--booking_table
CREATE TABLE booking (
    booking_id SERIAL PRIMARY KEY,
    booking_date DATE,
    property_id INTEGER,
    booked_by INTEGER,
    start_date DATE,
    end_date DATE,
    price DECIMAL(7, 2),
    booking_status INTEGER
);
--calendar_table
CREATE TABLE calendar (
    id SERIAL PRIMARY KEY,
    property_id INTEGER,
    is_available BOOLEAN,
    date DATE
);
--users
CREATE TABLE users (
    User_id SERIAL PRIMARY KEY,
    username VARCHAR(30),
    password VARCHAR(140)
);
--hosts
CREATE TABLE hosts (
    Host_id SERIAL PRIMARY KEY,
    user_id INTEGER,
    listing_id INTEGER
);