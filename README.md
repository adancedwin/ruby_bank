# The ruby_bank app

### Brief app description:
This is a simple banking application written in Ruby on Rails. It allows users to have accounts and make transfers between their own accounts and to other users accounts.

For the sake of simplicity we're are doing single entry bookkeeping. Meaning that all transactions are stored in a single ledger - Transactions table.

This not an ideal solution for a real world application, but it's good enough for this exercise.
The better alternative would be to use double entry bookkeeping, where each transaction would be stored in two tables - Debits and Credits. This would allow us to easily calculate account balance and other metrics. But it would also require more complex logic to handle transactions and would require more time to implement.

### All of the features the application includes:
- User can login into their account and logout;
- User can view the account balance;
- User can view the list of transactions made from the account or to the account;
- User can make a transfer between their own accounts and to other users accounts;
- Each account has a unique number and keeps track of their balance in a table column;

### Possible improvements:
- Add tests for controllers;
- Possibly add tests for the UI;
- Localization of user messages and view templates with 18n gem;
- More versatile record locking mechanism allowing for lesser amount of possible deadlocks and better performance;
- Better handling of transfer amount precision and validation;
- Randomize unit tests to make sure they don't depend on the order of execution;


# Setup
1. Run `bundle install` to install dependencies.
2. Run `bundle exec rake db:migrate` to create database, run migrations and seed data.
3. Run `bundle exec rspec` to run tests.
4. Run `bundle exec rails s` to start the server and go to `http://localhost:3000` to see the app.
You need to login under one of the existing users emails and password `1234567890` to go into user's account page.