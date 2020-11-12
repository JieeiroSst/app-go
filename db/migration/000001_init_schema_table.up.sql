CREATE TABLE "accounts"
(
  "id" bigserial PRIMARY KEY,
  "username" VARCHAR NOT NULL,
  "password" VARCHAR not NULL,
  "role_id" int,
  "created_at" timestamptz NOT NULL DEFAULT(now())
);

CREATE TABLE "roles"
(
  "id" bigserial PRIMARY KEY,
  "name" VARCHAR NOT NULL
);

CREATE TABLE "profiles"
(
  "id" bigserial PRIMARY KEY,
  "name" VARCHAR NOT NULL,
  "dob" timestamptz,
  "email" VARCHAR,
  "phone" VARCHAR,
  "status" int,
  "images" VARCHAR,
  "user_id" int
);


CREATE TABLE "banks"(
    "id" bigserial PRIMARY KEY,
    "name" varchar not null,
    "email" varchar not null
);

CREATE TABLE "branchs"(
    "id" bigserial PRIMARY KEY,
    "name" varchar not null,
    "city" varchar not null,
    "assets" int,
    "bank_id" int
);

CREATE TABLE "card"(
    "id" bigserial PRIMARY KEY,
    "bank_id" int,
    "card_number" int,
    "password_card" int,
    "card_type" int,
    "balance" int,
    "expired_data" timestamptz,
    "created_at" timestamptz NOT NULL DEFAULT(now()) 
);

CREATE TABLE "category_card"(
    "id" bigserial PRIMARY KEY,
    "name" varchar not null
);

create table "transaction"(
    "id" bigserial PRIMARY KEY,
    "user_transfer_id" int,
    "user_receiver_id" int,
    "amount" int 
);