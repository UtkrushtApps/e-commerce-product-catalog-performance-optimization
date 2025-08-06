-- Suboptimal schema with missing indexes on major filter columns
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS brands;

CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
    -- No unique or additional indexes
);

CREATE TABLE brands (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    category_id INTEGER NOT NULL,
    brand_id INTEGER NOT NULL,
    price NUMERIC(10,2) NOT NULL,
    description TEXT
    -- No foreign key constraints
    -- No indexes on category_id, brand_id
);

INSERT INTO categories(name) VALUES
 ('Electronics'), ('Clothing'), ('Books'), ('Home'), ('Outdoor');

INSERT INTO brands(name) VALUES
 ('Acme'), ('Globex'), ('Wayne'), ('Stark'), ('Umbrella');

INSERT INTO products (name, category_id, brand_id, price, description) VALUES
 ('Laptop Pro', 1, 4, 1199.99, 'High performance laptop'),
 ('Sneakers', 2, 2, 79.99, 'Lightweight running shoes'),
 ('Adventure Book', 3, 1, 19.99, 'A thrilling novel'),
 ('Espresso Machine', 4, 3, 249.99, 'Compact coffee maker'),
 ('Tent XL', 5, 5, 159.99, 'All-weather camping tent'),
 ('Smartphone Lite', 1, 1, 399.99, 'Affordable smartphone'),
 ('Jeans Classic', 2, 5, 49.99, 'Timeless blue jeans'),
 ('Sci-Fi Anthology', 3, 3, 22.50, 'Short story collection'),
 ('Vacuum Robot', 4, 2, 299.99, 'Auto-cleaning vacuum'),
 ('Camping Stove', 5, 4, 69.99, 'Portable stove for outdoors');
-- You may add more data for better query demonstration
