
-- HOTEL BOOKING MANAGEMENT SYSTEM
-- MYSQL MINI PROJECT

CREATE DATABASE HotelBookingManagement;
USE HotelBookingManagement;

-- TABLE 1: HOTELS

CREATE TABLE Hotels (
    hotel_id INT PRIMARY KEY AUTO_INCREMENT,
    hotel_name VARCHAR(50),
    city VARCHAR(30),
    star_rating INT
);

INSERT INTO Hotels (hotel_name, city, star_rating)
VALUES
('Grand Palace', 'Chennai', 5),
('Royal Inn', 'Bangalore', 4),
('Blue Moon', 'Hyderabad', 3);


-- TABLE 2: ROOMS

CREATE TABLE Rooms (
    room_id INT PRIMARY KEY AUTO_INCREMENT,
    hotel_id INT,
    room_number VARCHAR(10),
    room_type VARCHAR(20),
    price DECIMAL(10,2),
    status VARCHAR(20),

    FOREIGN KEY (hotel_id)
    REFERENCES Hotels(hotel_id)
);

INSERT INTO Rooms
(hotel_id, room_number, room_type, price, status)
VALUES
(1, '101', 'Standard', 2500, 'Available'),
(1, '102', 'Deluxe', 4000, 'Occupied'),
(1, '103', 'Suite', 7000, 'Occupied'),
(2, '201', 'Standard', 2200, 'Available'),
(2, '202', 'Deluxe', 3800, 'Occupied'),
(3, '301', 'Standard', 1800, 'Available'),
(3, '302', 'Suite', 6000, 'Occupied');


-- TABLE 3: GUESTS


CREATE TABLE Guests (
    guest_id INT PRIMARY KEY AUTO_INCREMENT,
    guest_name VARCHAR(50),
    phone VARCHAR(15),
    city VARCHAR(30)
);

INSERT INTO Guests
(guest_name, phone, city)
VALUES
('Rahul', '9876543210', 'Chennai'),
('Priya', '9876543211', 'Bangalore'),
('Arun', '9876543212', 'Hyderabad'),
('Sneha', '9876543213', 'Coimbatore'),
('Karthik', '9876543214', 'Mumbai');


-- TABLE 4: BOOKINGS

CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    guest_id INT,
    room_id INT,
    check_in DATE,
    check_out DATE,
    booking_status VARCHAR(20),

    FOREIGN KEY (guest_id)
    REFERENCES Guests(guest_id),

    FOREIGN KEY (room_id)
    REFERENCES Rooms(room_id)
);

INSERT INTO Bookings
(guest_id, room_id, check_in, check_out, booking_status)
VALUES
(1, 2, '2026-07-25', '2026-07-30', 'Completed'),
(2, 3, '2026-07-28', '2026-08-02', 'Active'),
(3, 5, '2026-07-29', '2026-08-01', 'Active'),
(4, 7, '2026-07-20', '2026-07-22', 'Completed'),
(1, 1, '2026-08-05', '2026-08-08', 'Booked'),
(5, 4, '2026-07-31', '2026-08-03', 'Cancelled');


-- TABLE 5: PAYMENTS


CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT,
    amount DECIMAL(10,2),
    payment_status VARCHAR(20),

    FOREIGN KEY (booking_id)
    REFERENCES Bookings(booking_id)
);

INSERT INTO Payments
(booking_id, amount, payment_status)
VALUES
(1, 20000, 'Paid'),
(2, 35000, 'Paid'),
(3, 12000, 'Pending'),
(4, 15000, 'Paid'),
(5, 7500, 'Pending'),
(6, 0, 'Refunded');

-- 1. Display Available Rooms

SELECT
    r.room_number,
    r.room_type,
    r.price,
    h.hotel_name
FROM Rooms r
JOIN Hotels h
ON r.hotel_id = h.hotel_id
WHERE r.status = 'Available';

-- 2. Find Guests Staying Today

SELECT
    g.guest_name,
    h.hotel_name,
    r.room_number,
    b.check_in,
    b.check_out
FROM Guests g
JOIN Bookings b
ON g.guest_id = b.guest_id
JOIN Rooms r
ON b.room_id = r.room_id
JOIN Hotels h
ON r.hotel_id = h.hotel_id
WHERE CURDATE() BETWEEN b.check_in AND b.check_out
AND b.booking_status = 'Active';

-- 3. Calculate Total Revenue

SELECT
    SUM(amount) AS Total_Revenue
FROM Payments
WHERE payment_status = 'Paid';

-- 4. Display Bookings Between Two Dates

SELECT
    b.booking_id,
    g.guest_name,
    h.hotel_name,
    b.check_in,
    b.check_out
FROM Bookings b
JOIN Guests g
ON b.guest_id = g.guest_id
JOIN Rooms r
ON b.room_id = r.room_id
JOIN Hotels h
ON r.hotel_id = h.hotel_id
WHERE b.check_in BETWEEN '2026-07-25' AND '2026-07-31';

-- 5. Find the Most Booked Room Type

SELECT
    r.room_type,
    COUNT(*) AS Total_Bookings
FROM Rooms r
JOIN Bookings b
ON r.room_id = b.room_id
GROUP BY r.room_type
ORDER BY Total_Bookings DESC
LIMIT 1;

-- 6. Calculate Occupancy Rate

SELECT
    ROUND(
        COUNT(CASE WHEN status = 'Occupied' THEN 1 END)
        * 100.0 / COUNT(*),
        2
    ) AS Occupancy_Rate
FROM Rooms;

-- 7. Display Cancelled Bookings

SELECT
    b.booking_id,
    g.guest_name,
    h.hotel_name,
    r.room_number
FROM Bookings b
JOIN Guests g
ON b.guest_id = g.guest_id
JOIN Rooms r
ON b.room_id = r.room_id
JOIN Hotels h
ON r.hotel_id = h.hotel_id
WHERE b.booking_status = 'Cancelled';

-- 8. Find Guests with Multiple Bookings

SELECT
    g.guest_name,
    COUNT(b.booking_id) AS Total_Bookings
FROM Guests g
JOIN Bookings b
ON g.guest_id = b.guest_id
GROUP BY g.guest_id, g.guest_name
HAVING COUNT(b.booking_id) > 1;

-- 9. Display Average Room Price

SELECT
    AVG(price) AS Average_Room_Price
FROM Rooms;

-- 10. Find Hotels with More Than 100 Rooms

SELECT
    h.hotel_name,
    COUNT(r.room_id) AS Total_Rooms
FROM Hotels h
JOIN Rooms r
ON h.hotel_id = r.hotel_id
GROUP BY h.hotel_id, h.hotel_name
HAVING COUNT(r.room_id) > 100;


-- 11. Find the Highest-Paying Guest

SELECT
    g.guest_name,
    SUM(p.amount) AS Total_Spent
FROM Guests g
JOIN Bookings b
ON g.guest_id = b.guest_id
JOIN Payments p
ON b.booking_id = p.booking_id
WHERE p.payment_status = 'Paid'
GROUP BY g.guest_id, g.guest_name
ORDER BY Total_Spent DESC
LIMIT 1;

-- 12. Hotel-Wise Revenue

SELECT
    h.hotel_name,
    SUM(p.amount) AS Revenue
FROM Hotels h
JOIN Rooms r
ON h.hotel_id = r.hotel_id
JOIN Bookings b
ON r.room_id = b.room_id
JOIN Payments p
ON b.booking_id = p.booking_id
WHERE p.payment_status = 'Paid'
GROUP BY h.hotel_id, h.hotel_name;

-- 13. Most Expensive Room

SELECT
    room_number,
    room_type,
    price
FROM Rooms
ORDER BY price DESC
LIMIT 1;

-- 14. Guests Who Have Never Made a Booking

SELECT
    g.guest_name
FROM Guests g
LEFT JOIN Bookings b
ON g.guest_id = b.guest_id
WHERE b.booking_id IS NULL;

-- 15. Rank Hotels by Revenue

SELECT
    h.hotel_name,
    SUM(p.amount) AS Revenue,
    RANK() OVER (
        ORDER BY SUM(p.amount) DESC
    ) AS Revenue_Rank
FROM Hotels h
JOIN Rooms r
ON h.hotel_id = r.hotel_id
JOIN Bookings b
ON r.room_id = b.room_id
JOIN Payments p
ON b.booking_id = p.booking_id
WHERE p.payment_status = 'Paid'
GROUP BY h.hotel_id, h.hotel_name;


-- 16. Display Complete Booking Details

SELECT
    b.booking_id,
    g.guest_name,
    g.phone,
    h.hotel_name,
    h.city,
    h.star_rating,
    r.room_number,
    r.room_type,
    r.price,
    b.check_in,
    b.check_out,
    b.booking_status,
    p.amount,
    p.payment_status
FROM Bookings b
JOIN Guests g
ON b.guest_id = g.guest_id
JOIN Rooms r
ON b.room_id = r.room_id
JOIN Hotels h
ON r.hotel_id = h.hotel_id
LEFT JOIN Payments p
ON b.booking_id = p.booking_id;

-- 17. Hotel-Wise Room Count

SELECT
    h.hotel_name,
    COUNT(r.room_id) AS Total_Rooms
FROM Hotels h
LEFT JOIN Rooms r
ON h.hotel_id = r.hotel_id
GROUP BY h.hotel_id, h.hotel_name;

-- 18. Room-Type-Wise Average Price

SELECT
    room_type,
    AVG(price) AS Average_Price
FROM Rooms
GROUP BY room_type;

-- 19. Count Bookings by Status

SELECT
    booking_status,
    COUNT(*) AS Total_Bookings
FROM Bookings
GROUP BY booking_status;

-- 20. Display Pending Payments

SELECT
    p.payment_id,
    g.guest_name,
    h.hotel_name,
    r.room_number,
    p.amount,
    p.payment_status
FROM Payments p
JOIN Bookings b
ON p.booking_id = b.booking_id
JOIN Guests g
ON b.guest_id = g.guest_id
JOIN Rooms r
ON b.room_id = r.room_id
JOIN Hotels h
ON r.hotel_id = h.hotel_id
WHERE p.payment_status = 'Pending';

-- 21. Find Hotels with 4 or More Star Rating

SELECT
    hotel_name,
    city,
    star_rating
FROM Hotels
WHERE star_rating >= 4;

-- 22. Find the Cheapest Room

SELECT
    room_number,
    room_type,
    price
FROM Rooms
ORDER BY price ASC
LIMIT 1;

-- 23. Calculate Total Pending Amount

SELECT
    SUM(amount) AS Pending_Amount
FROM Payments
WHERE payment_status = 'Pending';

-- 24. Count Total Guests

SELECT
    COUNT(*) AS Total_Guests
FROM Guests;

-- 25. Count Total Hotels

SELECT
    COUNT(*) AS Total_Hotels
FROM Hotels;

-- 26. Count Total Rooms

SELECT
    COUNT(*) AS Total_Rooms
FROM Rooms;

-- 27. Count Active Bookings

SELECT
    COUNT(*) AS Active_Bookings
FROM Bookings
WHERE booking_status = 'Active';

-- 28. Find Bookings Longer Than 3 Days

SELECT
    booking_id,
    guest_id,
    room_id,
    check_in,
    check_out,
    DATEDIFF(check_out, check_in) AS Stay_Days
FROM Bookings
WHERE DATEDIFF(check_out, check_in) > 3;

-- 29. Calculate Revenue by City

SELECT
    h.city,
    SUM(p.amount) AS Revenue
FROM Hotels h
JOIN Rooms r
ON h.hotel_id = r.hotel_id
JOIN Bookings b
ON r.room_id = b.room_id
JOIN Payments p
ON b.booking_id = p.booking_id
WHERE p.payment_status = 'Paid'
GROUP BY h.city;

-- 30. Display Active Bookings

SELECT
    b.booking_id,
    g.guest_name,
    h.hotel_name,
    r.room_number,
    r.room_type,
    b.check_in,
    b.check_out
FROM Bookings b
JOIN Guests g
ON b.guest_id = g.guest_id
JOIN Rooms r
ON b.room_id = r.room_id
JOIN Hotels h
ON r.hotel_id = h.hotel_id
WHERE b.booking_status = 'Active';