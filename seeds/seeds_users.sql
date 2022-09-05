--Create users table

-- Database :
-- Table - users ; columns - id , email, password

DROP TABLE IF EXISTS users; 

-- Table Definition
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email text,
    pass_word text
);

TRUNCATE TABLE users RESTART IDENTITY;

INSERT INTO users ("email", "pass_word") VALUES
('rex@rex.com', 'rex@123'),
('Rick@rick.com', 'rick@123')
;