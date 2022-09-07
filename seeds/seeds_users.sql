-- added cascade to prevent errors due to foreign key dependency  between spaces and users
DROP TABLE IF EXISTS users cascade; 


-- Table Definition
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email text,
    pass_word text
);

TRUNCATE TABLE users RESTART IDENTITY;

INSERT INTO users ("email", "pass_word") VALUES
('rex@rex.com', 'rex@123'),
('Rick@rick.com', 'rick@123'),
('maria@gmail.com', 'maria123@£@'),
('raz@razbugoi.co.uk', 'rxcvx21@!*&');