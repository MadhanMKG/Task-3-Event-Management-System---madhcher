# Task-3-Event-Management-System---madhcher
Application that allows users to Creat and manage events

**Event Management System**
This SQL script establishes a database for managing events, attendees, and registrations. It covers the creation of necessary tables, insertion of sample data, and various operations for managing event details, tracking attendees, and generating attendance statistics.

**Database Schema**
**The database is composed of three interconnected tables:**

**Events: Stores information about various events.**

Event_Id (SERIAL PRIMARY KEY)

Event_Name (VARCHAR(255) NOT NULL)

Event_Date (DATE NOT NULL)

Event_Location (VARCHAR(255))

Event_Description (TEXT)

**Attendees: Stores details of individuals attending events.**

Attendee_Id (SERIAL PRIMARY KEY)

Attendee_Name (VARCHAR(255) NOT NULL)

Attendee_Phone (VARCHAR(20))

Attendee_Email (VARCHAR(255) UNIQUE)

Attendee_City (VARCHAR(100))

**Registrations: Links attendees to events and records registration details.**

Registration_Id (SERIAL PRIMARY KEY)

Event_Id (INT NOT NULL, FOREIGN KEY references Events ON DELETE CASCADE)

Attendee_Id (INT NOT NULL, FOREIGN KEY references Attendees ON DELETE CASCADE)

Registration_Date (DATE NOT NULL)

Registration_Amount (DECIMAL(10, 2))

**Script Sections
Database and Table Creation:**

CREATE DATABASE EventsManagement;

CREATE TABLE Events (...)

CREATE TABLE Attendees (...)

CREATE TABLE Registrations (...)

**Data Creation:**

INSERT INTO Events VALUES (...)

INSERT INTO Attendees VALUES (...)

INSERT INTO Registrations VALUES (...)

Includes sample data for events, attendees, and their registrations.

**Manage Event Details:**

INSERT statement for adding a new event.

UPDATE statement for modifying an existing event's information.

DELETE statement for removing an event.

**Manage Track Attendees & Handle Events:**

INSERT statement for adding a new attendee.

INSERT statement for registering an attendee for an event.

**Reporting and Analytics Queries:**
Get all events with details: Lists all events ordered by date.

List of all attendees for events: Provides a list of all registered attendees.

Count number of attendees for each event: Calculates the total attendees per event.

Total collected registration amount per event: Sums the registration amounts for each event.

Find events that have no registrations yet: Identifies events without any registered attendees.

Number of events each attendee has registered for: Counts how many events each attendee has signed up for.

Breakdown of attendees by city: Groups attendees by city and counts them.

Most recent registrations DESC order: Lists recent registrations with attendee and event details.

**How to Use**
Execute the script: Run the TASK 3 - Event Management System.sql script in your SQL client. This will set up the database, tables, and populate them with initial data.

Perform operations: You can then execute the INSERT, UPDATE, and DELETE statements to manage your event data.

Generate reports: Run the various SELECT queries in section 5 to retrieve event information, attendee lists, and attendance statistics.

**Prerequisites**
An SQL database system (e.g., PostgreSQL, as SERIAL is used for auto-incrementing IDs). You may need to adjust SERIAL to AUTO_INCREMENT for MySQL or IDENTITY for SQL Server.

A SQL client to execute the script.
