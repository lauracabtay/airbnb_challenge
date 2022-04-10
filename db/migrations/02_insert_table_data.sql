--Listing table
INSERT INTO listing (title, description, location, price_per_night)
VALUES (
        '2 bed  apartment',
        'Lorem ipsum dolor sit amet',
        'London',
        350.00
    );
INSERT INTO listing (title, description, location, price_per_night)
VALUES (
        'Lovely studio in Camden Town',
        'Lorem ipsum dolor sit amet.',
        'London',
        280.00
    );
INSERT INTO listing (title, description, location, price_per_night)
VALUES (
        'Luxury apartment in Chelsea',
        'Lorem ipsum dolor sit amet.',
        'London',
        600.00
    );
--Booking table
INSERT INTO booking (
        booking_date,
        property_id,
        booked_by,
        start_date,
        end_date,
        price,
        booking_status
    )
VALUES (
        '2022-04-04',
        1,
        1,
        '2022-04-07',
        '2022-04-10',
        1050.00,
        1
    );
INSERT INTO booking (
        booking_date,
        property_id,
        booked_by,
        start_date,
        end_date,
        price,
        booking_status
    )
VALUES (
        '2022-04-04',
        3,
        2,
        '2022-04-04',
        '2022-04-11',
        4200.00,
        -1
    );
INSERT INTO booking (
        booking_date,
        property_id,
        booked_by,
        start_date,
        end_date,
        price,
        booking_status
    )
VALUES (
        '2022-04-05',
        2,
        3,
        '2022-04-06',
        '2022-04-08',
        560.00,
        0
    );
--Calendar table
INSERT INTO calendar (property_id, is_available, date)
VALUES (1, TRUE, '2022-04-04');
INSERT INTO calendar (property_id, is_available, date)
VALUES (1, TRUE, '2022-04-05');
INSERT INTO calendar (property_id, is_available, date)
VALUES (1, TRUE, '2022-04-06');
INSERT INTO calendar (property_id, is_available, date)
VALUES (1, FALSE, '2022-04-07');
INSERT INTO calendar (property_id, is_available, date)
VALUES (1, FALSE, '2022-04-08');
INSERT INTO calendar (property_id, is_available, date)
VALUES (1, FALSE, '2022-04-09');
INSERT INTO calendar (property_id, is_available, date)
VALUES (1, TRUE, '2022-04-10');
INSERT INTO calendar (property_id, is_available, date)
VALUES (2, TRUE, '2022-04-04');
INSERT INTO calendar (property_id, is_available, date)
VALUES (2, TRUE, '2022-04-05');
INSERT INTO calendar (property_id, is_available, date)
VALUES (2, FALSE, '2022-04-06');
INSERT INTO calendar (property_id, is_available, date)
VALUES (2, FALSE, '2022-04-07');
INSERT INTO calendar (property_id, is_available, date)
VALUES (2, TRUE, '2022-04-08');
INSERT INTO calendar (property_id, is_available, date)
VALUES (2, TRUE, '2022-04-09');
INSERT INTO calendar (property_id, is_available, date)
VALUES (2, TRUE, '2022-04-10');
INSERT INTO calendar (property_id, is_available, date)
VALUES (3, TRUE, '2022-04-04');
INSERT INTO calendar (property_id, is_available, date)
VALUES (3, TRUE, '2022-04-05');
INSERT INTO calendar (property_id, is_available, date)
VALUES (3, TRUE, '2022-04-06');
INSERT INTO calendar (property_id, is_available, date)
VALUES (3, TRUE, '2022-04-07');
INSERT INTO calendar (property_id, is_available, date)
VALUES (3, TRUE, '2022-04-08');
INSERT INTO calendar (property_id, is_available, date)
VALUES (3, TRUE, '2022-04-09');
INSERT INTO calendar (property_id, is_available, date)
VALUES (3, TRUE, '2022-04-10');
--users table
INSERT INTO users (username, password)
VALUES ('test@example.com', 'Password1');
INSERT INTO users (username, password)
VALUES ('test2@example.com', 'Password2');
INSERT INTO users (username, password)
VALUES ('test3@example.com', 'Password3');