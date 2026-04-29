#EXERCISE 2: Normalize an Airline Database
USE lab_week6;

CREATE TABLE customers(
    name VARCHAR(100) NOT NULL ,
    status VARCHAR(50),
    total_mileage INT,
    PRIMARY KEY (name)
);

CREATE TABLE flights(
    number VARCHAR(50) NOT NULL ,
    mileage INT,
    PRIMARY KEY (number)
);

CREATE TABLE aircrafts(
    aircraft VARCHAR(50) NOT NULL ,
    total_seats INT,
    PRIMARY KEY (aircraft)
);

CREATE TABLE bookings(
    id INT AUTO_INCREMENT,
    customer_name VARCHAR(100),
    flight_number VARCHAR(50),
    aircraft VARCHAR(50),
    PRIMARY KEY (id),
    FOREIGN KEY (customer_name) REFERENCES customers(name),
    FOREIGN KEY (flight_number) REFERENCES flights(number),
    FOREIGN KEY (aircraft) REFERENCES aircrafts(aircraft)
);

INSERT INTO customers (name, status, total_mileage)
VALUES ('Agustine Riviera','Silver','115235'),
       ('Alaina Sepulvida','None','6008'),
       ('Tom Jones','Gold','205767'),
       ('Sam Rio','None','2653'),
       ('Jessica James','Silver','127656'),
       ('Ana Janco','Silver','136773'),
       ('Jennifer Cortez','Gold','300582'),
       ('Christian Janco','Silver','14642');

INSERT INTO flights(number, mileage)
VALUES ('DL143','135'),
       ('DL122','4370'),
       ('DL53','2078'),
       ('DL222','1765'),
       ('DL37','531');

INSERT INTO aircrafts(aircraft, total_seats)
VALUES ('Boeing 747','400'),
       ('Airbus A330','236'),
       ('Boeing 777','264');

INSERT INTO bookings(customer_name, flight_number, aircraft)
VALUES ('Agustine Riviera','DL143','Boeing 747'),
       ('Agustine Riviera','DL122','Airbus A330'),
       ('Alaina Sepulvida','DL122','Airbus A330'),
       ('Agustine Riviera','DL143','Boeing 747'),
       ('Tom Jones','DL122','Airbus A330'),
       ('Tom Jones','DL53','Boeing 777'),
       ('Agustine Riviera','DL143','Boeing 747'),
       ('Sam Rio','DL143','Boeing 747'),
       ('Agustine Riviera','DL143','Boeing 747'),
       ('Tom Jones','DL222','Boeing 777'),
       ('Jessica James','DL143','Boeing 747'),
       ('Sam Rio','DL143','Boeing 747'),
       ('Ana Janco','DL222','Boeing 777'),
       ('Jennifer Cortez','DL222','Boeing 777'),
       ('Jessica James','DL122','Airbus A330'),
       ('Sam Rio','DL37','Boeing 747'),
       ('Christian Janco','DL222','Boeing 777');

#EXERCISE 3: Write SQL Queries on the Airline Database
#1.Total number of flights: 5

SELECT COUNT(DISTINCT number)
FROM flights;

#2. Average flight distance: 1775.8000
SELECT AVG(mileage) FROM flights;

#3. Average number of seats per aircraft: 300.0000
SELECT AVG(total_seats) FROM aircrafts;

#4. Average miles flown by customer, grouped by status: Silver: 98576.5000 / None: 4330.5000 / Gold: 253174.5000
SELECT status, AVG(total_mileage) FROM customers GROUP BY status;

#5. Max miles flown by customers, grouped by status: Silver: 136773 / None: 6008 / Gold:300582
SELECT status, MAX(total_mileage) FROM customers GROUP BY status;

#6. Number of aircrafts with "Boeing" in their name: 2
SELECT COUNT(*) FROM aircrafts WHERE aircraft LIKE '%Boeing%';

#7. Flights with distance between 300 and 2000 miles: DL222: 1765 / DL37: 531
SELECT * FROM flights WHERE mileage BETWEEN 300 AND 2000;

#8. Average flight distance booked, grouped by customer status: Silver: 1438.3333 / None,1292.7500 / Gold: 2494.5000
SELECT c.status, AVG(f.mileage)
FROM bookings b
         JOIN customers c ON b.customer_name = c.name
         JOIN flights f ON b.flight_number = f.number
GROUP BY c.status;

#9. Most booked aircraft among Gold status members: Boeing 777
SELECT a.aircraft, COUNT(*) AS total_bookings
FROM bookings b
         JOIN customers c ON b.customer_name = c.name
         JOIN flights f ON b.flight_number = f.number
         JOIN aircrafts a ON f.number = a.aircraft
WHERE c.status = 'Gold'
GROUP BY a.aircraft
ORDER BY total_bookings DESC
LIMIT 1;