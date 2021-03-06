DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS currency_rates;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS tags;
DROP TABLE IF EXISTS merchants;
DROP TABLE IF EXISTS currencies;

CREATE TABLE currencies (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE,
  short_name VARCHAR(255) NOT NULL
);

CREATE TABLE merchants (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE tags (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE users (
  id SERIAL4 PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255) NOT NULL,
  email VARCHAR(255),
  budget FLOAT8
);

CREATE TABLE transactions (
  id SERIAL4 PRIMARY KEY,
  user_id INT4 REFERENCES users(id),
  tag_id INT4 REFERENCES tags(id),
  merchant_id INT4 REFERENCES merchants(id),
  currency_id INT4 REFERENCES currencies(id),
  amount FLOAT8,
  trx_time timestamp
);

CREATE TABLE currency_rates (
  id SERIAL4 PRIMARY KEY,
  source_currency_id INT4 REFERENCES currencies(id),
  destination_currency_id INT4 REFERENCES currencies(id),
  rate FLOAT8,
  rate_date date
);
