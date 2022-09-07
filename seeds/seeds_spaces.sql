--DROP TABLE IF EXISTS users; 
-- added cascade to prevent errors due to foreign key dependency  between spaces and users
DROP TABLE IF EXISTS spaces cascade; 

-- Create the table without the foreign key first.
-- CREATE TABLE spaces (
--   id SERIAL PRIMARY KEY,
--   name text,
--   description text,
--   price int
-- );

-- Then the table with the foreign key first.
CREATE TABLE spaces (
  id SERIAL PRIMARY KEY,
  name text,
  description text,
  price int,
-- The foreign key name is always {other_table_singular}_id
  user_id int,
  constraint fk_user foreign key(user_id)
    references users(id)
    on delete cascade
);

TRUNCATE TABLE spaces RESTART IDENTITY;

INSERT INTO spaces ("name", "description", "price", "user_id") VALUES
('Swaines Cottage', 'This cottage dating back to 1352 has recently been renovated with new kitchen and adjoining dining room ', 500, 1),
('The Old Bakery', 'The Old Bakery is a luxurious self contained , detached cottage surrounded by woodland.', 130, 2),
('the BIG yurt', 'Huge Yurt on a small sustainable site in the heart of the South Downs National Park', 167, 1),
('Rose Cottage', 'Rose Cottage at Blackmoor Farm is a charming 16th century barn conversion on a picturesque farm in Surrey', 88, 3),
('Charming Countryside Annex', 'Our cosy annex has been lovingly decorated with my favourite furniture and accessories.', 156, 3),
('Grand Edwardian Country House', 'Situated on a hill in the picturesque Surrey Hills, the house has breathtaking view. It is the perfect spot for nature, biking and hiking lovers.', 1650, 3),
('IDYLLIC COUNTRY HOUSE', 'A beautifully decorated 16th Century farmhouse in a peaceful location only an hour from London.', 1100, 4);
