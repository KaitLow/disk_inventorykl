-- SWDV-220 
-- Author: Kait Low 
-- Date Created: 2/28/2020
-- Creates a database called disk_inventoryKL

USE master;
GO

--drops the databse if it already exists
DROP DATABASE IF EXISTS disk_inventorykl;
GO
--creates database
CREATE DATABASE disk_inventorykl;
GO

USE disk_inventorykl;
GO

--creates lookup tables
CREATE TABLE Genre(
	Genre_ID         INT NOT NULL PRIMARY KEY IDENTITY,
	[Description]    VARCHAR(60) NOT NULL
);

CREATE TABLE [Status](
	Status_ID        INT NOT NULL PRIMARY KEY IDENTITY,
	[Description]    VARCHAR(60) NOT NULL
);

CREATE TABLE Disk_type(
	Disk_type_ID     INT NOT NULL PRIMARY KEY IDENTITY,
	[Description]    VARCHAR(60) NOT NULL
);

CREATE TABLE Artist_type(
	Artist_type_ID   INT NOT NULL PRIMARY KEY IDENTITY,
	[Description]    VARCHAR(60) NOT NULL
);

CREATE TABLE Borrower(
	Borrower_ID      INT NOT NULL PRIMARY KEY IDENTITY,
	B_first_name     VARCHAR(60) NOT NULL,
	B_fist_name      VARCHAR(60) NOT NULL,
	B_phone_number   VARCHAR(10)
);

CREATE TABLE Artist(
	Artist_ID        INT NOT NULL PRIMARY KEY IDENTITY,
	A_first_name     VARCHAR(60) NOT NULL,
	A_fist_name      VARCHAR(60) NOT NULL,
	Artist_type_ID   INT NOT NULL REFERENCES Artist_type(Artist_type_ID)
);

CREATE TABLE [Disk](
	Disk_ID          INT NOT NULL PRIMARY KEY IDENTITY,
	Disk_name        VARCHAR(60) NOT NULL,
	Release_date     DATE NOT NULL,
	Status_ID        INT NOT NULL REFERENCES [Status](Status_ID),
	Genre_ID         INT NOT NULL REFERENCES Genre(Genre_ID),
	Disk_type_ID     INT NOT NULL REFERENCES Disk_type(Disk_type_ID)
);

CREATE TABLE Disk_has_artist(
	Disk_ID          INT NOT NULL REFERENCES [Disk](Disk_ID),
	Artist_ID        INT NOT NULL REFERENCES Artist(Artist_ID)
);

CREATE TABLE Disk_has_borrower(
	Disk_ID          INT NOT NULL REFERENCES [Disk](Disk_ID),
	Borrower_ID      INT NOT NULL REFERENCES Borrower(Borrower_ID),
	Borrowed_date    DATE NOT NULL,
	Returned_date    DATE NOT NULL,
	PRIMARY KEY (Borrower_ID, Disk_ID, Borrowed_date)
);

-- drop and create login/user diskUserkl
IF SUSER_ID('diskUserkl') IS NULL
	CREATE LOGIN diskUserkl WITH PASSWORD = 'Pa$$w0rd',
	DEFAULT_DATABASE = disk_inventorykl;

DROP USER IF EXISTS diskUserkl;

CREATE USER diskUserkl FOR LOGIN diskUserkl;

--grant permission to user
ALTER ROLE db_datareader ADD MEMBER diskUserkl;