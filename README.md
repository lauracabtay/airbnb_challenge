# MAKERSBNB CHALLENGE

## TEAM NAME

CREATE TEAM WHERE name LIKE '%a' (Team challenge)

## MAKERSBNB CHALLENGE

We are going to write a small Airbnb clone that will allow the users to create listings, as well as search and book properties.

## SETTING UP THE DATABASE

1. Connect to `psql` (you may need to install postgresql first by running `brew install postgres`)
2. Create the database using the psql command `CREATE DATABASE makersbnb`
3. Connect to the database using the psql command `\c makersbnb`
4. Run the queries we have saved in the file **01_create_tables.sql**
5. Populate your tables by running the queries we have saved in the file **02_insert_table_data.sql**

To check you have everything set up ok, please take a look at the `listing`, `booking`, `calendar`, `users` and `hosts` tables inside the makersbnb database.

## SETTING UP THE TEST DATABASE

1. Connect to `psql`
2. Create the test database using the psql command `CREATE DATABASE makersbnb_test`
3. Connect to the database using the psql command `\c makersbnb_test`
4. Run the queries we have saved in the file **01_create_tables.sql**

## START THE APP

- Run `bundle install` to add predefined package dependencies
- Run `rackup` and run the app on localhost 9292
- Run `rspec` to test code

## USER STORIES

```
As a user
So that I can find a place to stay
I want to properties by location, dates and price.
```

```
As a user
So that I can find a place to stay
I want to see the available places for me.
```

```
As a user,
So that I can know more about a listing details
I want to click on a listing and see its description
```

```
As a user,
So that I can stay in the place I've  chosen,
I want to book a place on specified dates.
```

```
As a user
So that I can access my profile
I want to log in
```

```
As a user
So that I can access all functionalities
I want to register
```

```
As a host
So that I can rent my place
I want to create a listing
```

```
As a host,
So that I can stop renting out my place
I want to delete a listing
```
