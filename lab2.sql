CREATE DATABASE Lab2;
USE Lab2;
CREATE TABLE BOOKS(
    id INT AUTO_INCREMENT PRIMARY KEY ,
    reader_id INT,
    title VARCHAR(50),
    author VARCHAR(50),
    yearPublished date
);

CREATE TABLE LOANS(
    id INT AUTO_INCREMENT PRIMARY KEY ,
    book_id INT,
    reader_id INT,
    dateLoaned date,
    dateReturned date,
    FOREIGN KEY (book_id)
                  REFERENCES BOOKS(id),
    FOREIGN KEY (reader_id)
                  REFERENCES BOOKS(reader_id)


);

CREATE TABLE READERS(
    id INT AUTO_INCREMENT PRIMARY KEY ,
    name VARCHAR(50),
    adress varchar(50),
    phone INT(10) NOT NULL
);
INSERT INTO BOOKS(title,author,yearPublished)
VALUES ('t1','a1','2000-09-19'),
       ('t2','a2','2023-01-19'),
       ('t3','a3','2024-09-14');
SELECT *
FROM BOOKS




