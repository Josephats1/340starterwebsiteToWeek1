-- Create ENUM type
CREATE TYPE account_role AS ENUM ('User', 'Admin');

-- Accounts table
CREATE TABLE account (
    account_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    account_type account_role DEFAULT 'User'
);

-- Classification table
CREATE TABLE classification (
    classification_id SERIAL PRIMARY KEY,
    classification_name VARCHAR(50) NOT NULL UNIQUE
);

-- Inventory table
CREATE TABLE inventory (
    inv_id SERIAL PRIMARY KEY,
    inv_make VARCHAR(50) NOT NULL,
    inv_model VARCHAR(50) NOT NULL,
    inv_description TEXT,
    inv_image VARCHAR(255),
    inv_thumbnail VARCHAR(255),
    classification_id INT NOT NULL,
    CONSTRAINT fk_classification FOREIGN KEY (classification_id)
        REFERENCES classification (classification_id)
        ON UPDATE CASCADE
        ON DELETE NO ACTION
);

-- Insert data into classification
INSERT INTO classification (classification_name) VALUES
('SUV'), ('Truck'), ('Sport')
ON CONFLICT (classification_name) DO NOTHING;

-- Insert sample inventory dynamically
INSERT INTO inventory (inv_make, inv_model, inv_description, inv_image, inv_thumbnail, classification_id)
VALUES
('GM', 'Hummer', 'Known for small interiors', '/images/hummer.jpg', '/images/hummer-tn.jpg', 
 (SELECT classification_id FROM classification WHERE classification_name = 'SUV')),
('Ford', 'Raptor', 'High performance sport truck', '/images/raptor.jpg', '/images/raptor-tn.jpg',
 (SELECT classification_id FROM classification WHERE classification_name = 'Truck')),
('Chevy', 'Corvette', 'Sporty and fast', '/images/corvette.jpg', '/images/corvette-tn.jpg',
 (SELECT classification_id FROM classification WHERE classification_name = 'Sport'));

-- Task One query #4
UPDATE inventory
SET inv_description = REPLACE(inv_description, 'small interiors', 'a huge interior')
WHERE inv_make = 'GM' AND inv_model = 'Hummer';

-- Task One query #6
UPDATE inventory
SET inv_image = REPLACE(inv_image, '/images/', '/images/vehicles/'),
    inv_thumbnail = REPLACE(inv_thumbnail, '/images/', '/images/vehicles/');

