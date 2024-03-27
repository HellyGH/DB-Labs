CREATE DATABASE LibrarySystem;
use LibrarySystem;

CREATE TABLE Publishers(
    id INT AUTO_INCREMENT PRIMARY KEY ,
    name VARCHAR(255),
    address VARCHAR(255)
);
#inserting data
INSERT INTO Publishers (id, name, address) VALUES
(1, 'Penguin Random House', '1745 Broadway, New York, NY 10019, USA'),
(2, 'TU-Sofia', '195 Broadway, New York, NY 10007, USA'),
(3, 'TU-Sofia', '1230 Avenue of the Americas, New York, NY 10020, USA'),
(4, 'Macmillan Publishers', '120 Broadway, New York, NY 10271, USA'),
(5, 'TU-Sofia', '1290 Avenue of the Americas, New York, NY 10104, USA');

CREATE TABLE Books(
    id INT AUTO_INCREMENT PRIMARY KEY ,
    publisher_id INT,
    title VARCHAR(255),
    description VARCHAR(255),
    FOREIGN KEY (publisher_id) REFERENCES Publishers(id)
);
#inserting data
INSERT INTO Books(id, publisher_id, title, description) VALUES
(1, 1, 'The Great Gatsby', 'A novel written by American author F. Scott Fitzgerald.'),
(2, 2, 'To Kill a Mockingbird', 'A novel by Harper Lee set in the American South during the 1930s.'),
(3, 3, '1984', 'A dystopian social science fiction novel by George Orwell.'),
(4, 4, 'Harry Potter and the Philosopher''s Stone', 'The first novel in the Harry Potter series written by J.K. Rowling.'),
(5, 5, 'The Catcher in the Rye', 'A novel by J.D. Salinger.');


CREATE TABLE LoanBooks(
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    date DATE,
    book_id INT,
    FOREIGN KEY (user_id) REFERENCES Users(id),
    FOREIGN KEY (book_id) REFERENCES Books(id)
);
#inserting data
INSERT INTO LoanBooks(id, user_id,date,book_id) VALUES
(1,1, '2023-12-01', 1),
(2,2, '2023-12-02', 2),
(3,3, '2023-12-03', 3),
(4,4, '2023-12-04', 4),
(5,5, '2023-12-05', 5);



CREATE TABLE UserRole(
    id INT PRIMARY KEY ,
    RoleName VARCHAR(100)
);
#insert data
INSERT INTO UserRole(id, RoleName) VALUES
(1, 'Admin'),
(2, 'User'),
(3, 'Editor'),
(4, 'Guest'),
(5, 'Moderator');



CREATE TABLE Users(
    id INT AUTO_INCREMENT PRIMARY KEY ,
    name VARCHAR(255),
    egn VARCHAR(10),
    pass INT,
    phone VARCHAR(10),
    email VARCHAR(50),
    role_id INT,
    FOREIGN KEY (role_id) REFERENCES UserRole(id)
);

#inserting data
INSERT INTO Users(id, name, egn, pass, phone, email, role_id) VALUES
(1, 'John Smith', '1234567890', 123456, '1234567890', 'john@example.com',1),
(2, 'Emily Johnson', '0987654321', 654321, '0987654321', 'emily@example.com',2),
(3, 'Michael Brown', '4567890123', 456789, '4567890123', 'michael@example.com',3),
(4, 'Emma Davis', '5678901234', 567890, '5678901234', 'emma@example.com',4),
(5, 'James Wilson', '6789012345', 678901, '6789012345', 'james@example.com',5);

CREATE TABLE Authors(
    id INT AUTO_INCREMENT PRIMARY KEY ,
    name VARCHAR(255),
    information VARCHAR(255)
);
#inserting data
INSERT INTO  Authors(id, name, information) VALUES
(1, 'Stephen King', 'American author known for his horror and supernatural fiction.'),
(2, 'J.K. Rowling', 'British author best known for the Harry Potter fantasy series.'),
(3, 'Agatha Christie', 'English writer known for her detective novels and short story collections.'),
(4, 'George Orwell', 'English novelist, essayist, journalist, and critic.'),
(5, 'Jane Austen', 'English novelist known primarily for her six major novels, which interpret, critique, and comment upon the British landed gentry at the end of the 18th century.');

CREATE TABLE BookAuthors(
    book_id INT,
    author_id INT,

    FOREIGN KEY (book_id) REFERENCES Books(id),
    FOREIGN KEY (author_id) REFERENCES Authors(id),
    PRIMARY KEY (book_id,author_id)

);
#inserting data
INSERT INTO BookAuthors(book_id, author_id) VALUES
(1, 1),  -- Book 1 is written by Author 1
(1, 2),  -- Book 1 is also written by Author 2
(4, 2),  -- Book 2 is written by Author 3
(3, 4),  -- Book 3 is written by Author 4
(3, 5);-- Book 3 is also written by Author 5

CREATE TABLE Genres(
    id INT AUTO_INCREMENT PRIMARY KEY ,
    name VARCHAR(255)
);
#inserting data
INSERT INTO Genres(id, name) VALUES
(1, 'Fiction'),
(2, 'Non-fiction'),
(3, 'Mystery'),
(4, 'Science Fiction'),
(5, 'Fantasy');

CREATE TABLE BookGenre (
    book_id INT,
    genre_id INT,
    PRIMARY KEY (book_id, genre_id),
    FOREIGN KEY (book_id) REFERENCES Books(id),
    FOREIGN KEY (genre_id) REFERENCES Genres(id)
);

-- Inserting data into the BookGenre table
INSERT INTO BookGenre (book_id, genre_id) VALUES
(1, 5),  -- The Great Gatsby: Fantasy
(2, 1),  -- To Kill a Mockingbird: Fiction
(3, 4),  -- 1984: Science Fiction
(4, 1),  -- Harry Potter and the Philosopher's Stone: Fiction
(5, 1);  -- The Catcher in the Rye: Fiction

CREATE VIEW info_books
AS
SELECT books.title AS book_name,
       books.description AS book_des,
       GROUP_CONCAT(authors.name) AS author_name,
       GROUP_CONCAT(genres.name) AS genre,
       publishers.name AS publisher
FROM books
LEFT JOIN publishers ON books.publisher_id = publishers.id
LEFT JOIN BookAuthors ON books.id = BookAuthors.book_id
LEFT JOIN Authors ON BookAuthors.author_id = authors.id
LEFT JOIN BookGenre ON books.id = BookGenre.book_id
LEFT JOIN Genres ON BookGenre.genre_id = genres.id
GROUP BY
    books.title,
	books.description,
	publishers.name;


SELECT b.Title AS Title,COALESCE(p.Name,'No publisher') AS Publisher
FROM Books b
JOIN Publishers P on b.publisher_id = P.id;

SELECT a1.name AS author1, a2.name AS author2, b.title AS name
FROM books AS b
JOIN BookAuthors AS ba1 ON b.id = ba1.book_id
JOIN authors AS a1 ON ba1.author_id = a1.id
JOIN BookAuthors AS ba2 ON b.id = ba2.book_id
JOIN authors AS a2 ON ba2.author_id = a2.id
WHERE a1.id > a2.id
ORDER BY name;

SELECT u.name AS Name,
u.email AS Email, u.phone AS Phone,COUNT(lb.id) AS Number
FROM Users AS u
JOIN LoanBooks AS lb ON u.id = lb.user_id
JOIN Books B on lb.book_id = B.id
JOIN Publishers P on B.publisher_id = P.id
WHERE P.Name = 'TU-Sofia'
GROUP BY lb.user_id
HAVING Number = 1;






