-- 1. Create the database
CREATE DATABASE EventsManagement;

-- Create the Events table
CREATE TABLE Events (
    Event_Id SERIAL PRIMARY KEY,
    Event_Name VARCHAR(255) NOT NULL,
    Event_Date DATE NOT NULL,
    Event_Location VARCHAR(255),
    Event_Description TEXT
);

-- Create the Attendees table
CREATE TABLE Attendees (
    Attendee_Id SERIAL PRIMARY KEY,
    Attendee_Name VARCHAR(255) NOT NULL,
    Attendee_Phone VARCHAR(20),
    Attendee_Email VARCHAR(255) UNIQUE,
    Attendee_City VARCHAR(100)
);

-- Create the Registrations table
CREATE TABLE Registrations (
    Registration_Id SERIAL PRIMARY KEY,
    Event_Id INT NOT NULL,
    Attendee_Id INT NOT NULL,
    Registration_Date DATE NOT NULL,
    Registration_Amount DECIMAL(10, 2),
    FOREIGN KEY (Event_Id) REFERENCES Events(Event_Id) ON DELETE CASCADE,
    FOREIGN KEY (Attendee_Id) REFERENCES Attendees(Attendee_Id) ON DELETE CASCADE
);

-- 2. Data Creation
-- Insert sample events
INSERT INTO Events (Event_Name, Event_Date, Event_Location, Event_Description)
VALUES 
('Tech Conference 2025', '2025-09-10', 'Hyderabad', 'Annual technology conference'),
('Music Festival', '2025-08-05', 'Bangalore', 'Outdoor live music festival'),
('Startup Meetup', '2025-10-15', 'Chennai', 'Networking event for startups and entrepreneurs'),
('AI Workshop', '2025-11-05', 'Pune', 'Hands-on workshop on Artificial Intelligence'),
('Food Carnival', '2025-12-01', 'Mumbai', 'Street food and cultural festival'),
('Sports Summit', '2025-09-25', 'Delhi', 'Annual sports leadership summit'),
('Health & Wellness Expo', '2025-11-20', 'Kolkata', 'Expo focusing on health, fitness, and wellness trends');

-- Insert sample attendees
INSERT INTO Attendees (Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City)
VALUES 
('Alice Johnson', '9876543210', 'alice.johnson@example.com', 'Hyderabad'),
('Bob Smith', '9123456789', 'bob.smith@example.com', 'Bangalore'),
('Charlie Davis', '9988776655', 'charlie.davis@example.com', 'Chennai'),
('Diana Patel', '9876123456', 'diana.patel@example.com', 'Pune'),
('Ethan Brown', '9123456781', 'ethan.brown@example.com', 'Mumbai'),
('Fatima Khan', '9876541230', 'fatima.khan@example.com', 'Delhi'),
('George Mathew', '9012345678', 'george.mathew@example.com', 'Kolkata');

-- Insert sample registrations
INSERT INTO Registrations (Event_Id, Attendee_Id, Registration_Date, Registration_Amount)
VALUES 
(1, 1, '2025-07-20', 1500.00),
(2, 2, '2025-07-21', 2000.00),
(3, 3, '2025-07-22', 1000.00),
(4, 4, '2025-07-23', 2500.00),
(5, 5, '2025-07-24', 800.00),
(6, 6, '2025-07-25', 1200.00),
(7, 7, '2025-07-26', 1800.00);

-- 3.Manage Event details
-- a) Insert a new event
INSERT INTO Events (Event_Name, Event_Date, Event_Location, Event_Description)
VALUES ('Developer Hackathon', '2025-12-15', 'Visakhapatnam', '48-hour coding and innovation hackathon');

-- b) Update an event's information
UPDATE Events
SET Event_Location = 'Pune', Event_Description = 'Outdoor live music festival'
WHERE Event_Name = 'Music Festival';

-- c) Delete an event
DELETE FROM Events
WHERE Event_Name = 'Startup Meetup';


-- 4. Manage Track Attendees & Handle Events
-- a) Insert a new attendee
INSERT INTO Attendees (Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City)
VALUES ('Hannah Wright', '9876001234', 'hannah.wright@example.com', 'Visakhapatnam');

-- b) Register an attendee for an event
INSERT INTO Registrations (Event_Id, Attendee_Id, Registration_Date, Registration_Amount)
VALUES (8, 8, '2025-07-27', 2000.00);


-- 5. Develop queries to retrieve event information, generate attendee lists, and calculate event attendance statistics.
-- Get all events with details
SELECT Event_Id, Event_Name, Event_Date, Event_Location, Event_Description
FROM Events
ORDER BY Event_Date;

-- List of all attendees for events 
SELECT Attendee_Id, Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City
FROM Attendees ;

-- Count number of attendees for each event
SELECT E.Event_Name, COUNT(R.Registration_Id) AS Total_Attendees
FROM Events E
LEFT JOIN Registrations R ON E.Event_Id = R.Event_Id
GROUP BY E.Event_Id, E.Event_Name
ORDER BY Total_Attendees DESC;

-- Total collected registration amount per event
SELECT E.Event_Name,COALESCE(SUM(R.Registration_Amount), 0) AS Total_Revenue
FROM Events E
LEFT JOIN Registrations R ON E.Event_Id = R.Event_Id
GROUP BY E.Event_Id, E.Event_Name
ORDER BY Total_Revenue DESC;

-- Find events that have no registrations yet
SELECT E.Event_Id, E.Event_Name, E.Event_Date, E.Event_Location
FROM Events E
LEFT JOIN Registrations R ON E.Event_Id = R.Event_Id
WHERE R.Registration_Id IS NULL;

-- Number of events each attendee has registered for
SELECT A.Attendee_Name,COUNT(R.Registration_Id) AS Events_Registered
FROM Attendees A
LEFT JOIN Registrations R ON A.Attendee_Id = R.Attendee_Id
GROUP BY A.Attendee_Id, A.Attendee_Name
ORDER BY Events_Registered DESC;

-- Breakdown of attendees by city
SELECT Attendee_City,COUNT(*) AS Total_Attendees
FROM Attendees
GROUP BY Attendee_City
ORDER BY Total_Attendees DESC;

-- Most recent registrations DESC order
SELECT A.Attendee_Name, E.Event_Name, R.Registration_Date, R.Registration_Amount
FROM Registrations R
JOIN Attendees A ON R.Attendee_Id = A.Attendee_Id
JOIN Events E ON R.Event_Id = E.Event_Id
ORDER BY R.Registration_Date DESC;


