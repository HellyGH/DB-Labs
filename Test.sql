CREATE DATABASE DB;
USE DB;
CREATE TABLE employees(
    id INT AUTO_INCREMENT PRIMARY KEY ,
    name VARCHAR(50),
    position varchar(50),
    salary decimal(10,2)

);

INSERT INTO employees( name, position, salary)
VALUES
    ('Helly Hristowa','Manager',50000.0),
     ('Katrin Hristowa','Sales Rep',30000.0),
      ('Alex Georgiev','Developer',40000.0),
       ('Emily Davis','HR',35000.0);
