Hotel Booking Management System
Project Description

The Hotel Booking Management System is a MySQL database mini project designed to simulate the booking and management operations of a hotel chain.

The system manages information about hotels, rooms, guests, bookings, and payments. It allows users to track room availability, guest stays, bookings, cancellations, payments, occupancy, and hotel revenue.

The project demonstrates practical MySQL concepts including primary keys, foreign keys, one-to-many relationships, INNER JOIN, LEFT JOIN, aggregate functions, GROUP BY, HAVING, date functions, subqueries, and window functions.

Objectives

Store information about multiple hotels.

Maintain room details for each hotel.

Store guest information.

Manage guest room bookings.

Track check-in and check-out dates.

Track booking status.

Maintain payment information.

Identify available and occupied rooms.

Calculate hotel revenue.

Calculate occupancy rates.

Analyze room booking trends.

Rank hotels based on revenue.

Database Structure

The database contains five tables:

Hotels
   |
   | 1 : M
   |
Rooms
   |
   | 1 : M
   |
Bookings
   |        ^
   |        |
   |        |
   +------ Guests
   |
   | 1 : 1
   |
Payments

Hotels

Stores information about hotels.

hotel_id - Primary Key

hotel_name - Name of the hotel

city - Hotel location

star_rating - Hotel rating

Rooms

Stores room information.

room_id - Primary Key

hotel_id - Foreign Key

room_number - Room number

room_type - Standard, Deluxe, Suite

price - Room price

status - Available/Occupied

Guests

Stores guest information.

guest_id - Primary Key

guest_name - Guest name

phone - Contact number

city - Guest city

Bookings

Stores reservation information.

booking_id - Primary Key

guest_id - Foreign Key

room_id - Foreign Key

check_in - Check-in date

check_out - Check-out date

booking_status - Booked/Active/Completed/Cancelled

Payments

Stores payment information.

payment_id - Primary Key

booking_id - Foreign Key

amount - Payment amount

payment_status - Paid/Pending/Refunded

Sample Data

The project contains sample data for:

3 hotels

7 rooms

5 guests

6 bookings

6 payments

Hotels
Hotel	City	Rating
Grand Palace	Chennai	5
Royal Inn	Bangalore	4
Blue Moon	Hyderabad	3
Room Types

The database contains:

Standard

Deluxe

Suite

Booking Status

Booked

Active

Completed

Cancelled

Payment Status

Paid

Pending

Refunded

SQL Concepts Demonstrated

This project demonstrates:

Database creation

Table creation

Primary Keys

Foreign Keys

AUTO_INCREMENT

One-to-Many relationships

One-to-One relationship

INNER JOIN

LEFT JOIN

WHERE

GROUP BY

HAVING

ORDER BY

LIMIT

COUNT()

SUM()

AVG()

ROUND()

RANK()

CASE

CURDATE()

BETWEEN

DATEDIFF()

Window Functions

Aggregate Functions

Date filtering

Main Queries

The project includes queries for:

Displaying available rooms.

Finding guests staying today.

Calculating total revenue.

Displaying bookings between two dates.

Finding the most booked room type.

Calculating occupancy rate.

Displaying cancelled bookings.

Finding guests with multiple bookings.

Calculating average room price.

Finding hotels with more than 100 rooms.

Finding the highest-paying guest.

Calculating hotel-wise revenue.

Finding the most expensive room.

Finding guests who never made a booking.

Ranking hotels by revenue.

Additional queries are included for complete booking details, room statistics, payment reports, booking status analysis, stay duration, city-wise revenue, and active bookings.

How to Run
Step 1: Install MySQL

Install MySQL Server and MySQL Workbench.

Step 2: Open MySQL Workbench

Connect to your MySQL server.

Step 3: Open the SQL File

Open:

hotel_booking_management.sql

Step 4: Execute the Script

Run the complete SQL script.

The script will:

Create the HotelBookingManagement database.

Create all five tables.

Insert sample data.

Execute the practice queries.

Project Structure
HOTEL BOOKING MANAGEMENT/
│
├── hotel_booking_management.sql
└── README.md

Technologies Used

Database: MySQL

Query Language: SQL

Database Tool: MySQL Workbench

Version Control: Git & GitHub

Key Features

Hotel management

Room management

Guest management

Booking management

Payment tracking

Cancellation tracking

Room availability

Occupancy calculation

Revenue calculation

Hotel revenue ranking

Guest booking analysis

Future Enhancements

The project can be extended with:

Online room booking

Customer login

Admin login

Check-in/check-out management

Multiple payment methods

Invoice generation

Room maintenance tracking

Customer reviews and ratings

Hotel staff management

Seasonal room pricing

Booking cancellation charges

Hotel management dashboard

