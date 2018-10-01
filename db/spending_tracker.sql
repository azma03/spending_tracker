DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS tags;
DROP TABLE IF EXISTS merchants;
DROP TABLE IF EXISTS currencies;

CREATE TABLE currencies (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  short_name VARCHAR(255) NOT NULL
);

CREATE TABLE merchants (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

CREATE TABLE tags (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255) NOT NULL
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
  user_id INT4 REFERENCES users(id) ON DELETE CASCADE,
  tag_id INT4 REFERENCES tags(id) ON DELETE CASCADE,
  merchant_id INT4 REFERENCES merchants(id) ON DELETE CASCADE,
  currency_id INT4 REFERENCES currencies(id) ON DELETE CASCADE,
  amount FLOAT8,
  trx_time timestamp
);
