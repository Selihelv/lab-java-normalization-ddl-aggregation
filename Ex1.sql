USE lab_week6;

CREATE TABLE author (
    author_name VARCHAR(100) NOT NULL ,
    PRIMARY KEY (author_name)
);

CREATE TABLE books (
    title      VARCHAR(100) NOT NULL ,
    word_count INT,
    views      INT,
    PRIMARY KEY (title)
);

CREATE TABLE author_books
(
    id        INT AUTO_INCREMENT,
    author_name VARCHAR(100),
    book_title   VARCHAR(100),
    PRIMARY KEY (id),
    FOREIGN KEY (author_name) REFERENCES author (author_name),
    FOREIGN KEY (book_title) REFERENCES books (title)
);

INSERT INTO author(author_name)
VALUES ('Maria Charlotte'),
       ('Juan Perez'),
       ('Gemma Alcocer');

INSERT INTO books (title, word_count, views)
VALUES ('Best Paint Colors', '814', '14'),
       ('Small Space Decorating Tips', '1146','221'),
       ('Hot Accessories', '986','105'),
       ('Mixing Textures', '765','22'),
       ('Kitchen Refresh', '1242','307'),
       ('Homemade Art Hacks', '1002','193'),
       ('Refinishing Wood Floors', '1571','7542');

INSERT INTO author_books(author_name, book_title)
VALUES ('Maria Charlotte','Best Paint Colors'),
       ('Maria Charlotte','Hot Accessories'),
       ('Maria Charlotte','Mixing Textures'),
       ('Maria Charlotte','Homemade Art Hacks'),
       ('Juan Perez','Small Space Decorating Tips'),
       ('Juan Perez','Kitchen Refresh'),
       ('Gemma Alcocer','Refinishing Wood Floors');