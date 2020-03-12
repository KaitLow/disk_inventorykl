-- SWDV-220 
-- Author: Kait Low 
-- Date Created: 2/28/2020
-- Creates a database called disk_inventoryKL
--File Includes Project 2 & 3
--Project 3 Added 3/5/2020

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
	B_last_name      VARCHAR(60) NOT NULL,
	B_phone_number   VARCHAR(12)
);

CREATE TABLE Artist(
	Artist_ID        INT NOT NULL PRIMARY KEY IDENTITY,
	A_first_name     VARCHAR(60) NOT NULL,
	A_last_name      VARCHAR(60) ,
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
	Artist_ID        INT NOT NULL REFERENCES Artist(Artist_ID),
);

CREATE TABLE Disk_has_borrower(
	Disk_ID          INT NOT NULL REFERENCES [Disk](Disk_ID),
	Borrower_ID      INT NOT NULL REFERENCES Borrower(Borrower_ID),
	Borrowed_date    DATE NOT NULL,
	Returned_date    DATE,
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

--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--Start of Week 3 Assignment 3/5/2019
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
USE [disk_inventorykl]
GO

--Insert status value
INSERT INTO [dbo].[Status]
           ([Description])
     VALUES
           ('Available')
		   ,('On Loan')
		   ,('Damaged')
		   ,('Missing');
GO

--Insert disk genre
INSERT INTO [dbo].[Genre]
           ([Description])
     VALUES
           ('Classic Rock')
		   ,('Country')
		   ,('Jazz')
		   ,('AltRock')
		   ,('Metal');
GO

--Insert disk type
INSERT INTO [dbo].[Disk_type]
           ([Description])
     VALUES
           ('CD')
		   ,('Vinyl')
		   ,('gTrack')
		   ,('DVD');
GO

--Insert artist type
INSERT INTO [dbo].[Artist_type]
           ([Description])
     VALUES
           ('Solo')
		   ,('Group');
GO

--Insert disk rows part C
INSERT INTO [dbo].[Disk]
           ([Disk_name]
           ,[Release_date]
           ,[Status_ID]
           ,[Genre_ID]
           ,[Disk_type_ID])
     VALUES
           ('Crazy Train','1/1/1995',1,1,1)
		   ,('No More Tears', '11/21/1995',1,1,1)
		   ,('Red','11/13/2000',2,2,1)
		   ,('Jagged Little Pill','1/15/1995',1,2,1)
		   ,('Candy-O','10/10/1992',1,2,2)
		   ,('Hotel California','11/1/1977',1,2,2)
		   ,('One of These Nights','4/1/1975',1,2,2)
		   ,('The Long Run','10/21/1979',1,2,2)
		   ,('Hints, Allegations, and Things Left Unsaid','1/21/1999',4,2,1)
		   ,('Blender','1/29/2000',4,1,1)
		   ,('Dirt','1/27/1992',4,1,2)
		   ,('Unplugged','5/23/1996',4,1,2)
		   ,('Facelift','1/11/1998',4,1,2)
		   ,('Black Gives Way to Blue','11/21/2000',4,1,2)
		   ,('Live','11/11/2000',4,1,2)
		   ,('Ten','12/2/1991',4,1,2)
		   ,('Vitology','3/22/1994',4,1,2)
		   ,('No Code','4/2/1996',4,1,2)
		   ,('Backspacer','5/21/2000',4,1,2)
		   ,('Home','1/19/1995',1,2,1);
GO

UPDATE Disk
SET Release_date = '11/11/2011'
WHERE Disk_ID = 20;
GO

--Insert borrower rows part D
INSERT INTO [dbo].[Borrower]
           ([B_first_name]
           ,[B_last_name]
           ,[B_phone_number])
     VALUES
           ('Mickey','Mouse','111-111-1234')
		   ,('Minnie','Mouse','111-222-1234')
		   ,('Daisy','Duck','111-333-1234')
		   ,('Daffy','Duck','111-444-1234')
		   ,('Donald','Duck','111-555-1234')
		   ,('Huey','Duck','111-666-1234')
		   ,('Dewey','Duck','111-777-1234')
		   ,('Louie','Duck','111-888-1234')
		   ,('Elmer','Fudd','111-999-1234')
		   ,('Buzz','Lightyear','222-111-1234')
		   ,('Sheriff','Woody','222-222-1234')
		   ,('Little Bo','Peep','222-333-1234')
		   ,('T','Rex','222-444-1234')
		   ,('Mrs. Potato','Head','222-555-1234')
		   ,('Slinky','Dog','222-666-1234')
		   ,('Mr.','Spell','222-777-1234')
		   ,('Race','Car','222-888-1234')
		   ,('Sargeant','Soldier','222-999-1234')
		   ,('Jessie','Cowgirl','333-111-1234')
		   ,('Mr. Potato','Head','333-222-1234');
GO

--Delete the last borrower
DELETE Borrower
WHERE Borrower_ID = 20;

--Insert artist rows part E
INSERT INTO [dbo].[Artist]
           ([A_first_name]
           ,[A_last_name]
           ,[Artist_type_ID])
     VALUES
           ('Ozzy','Osbourne',1)
		   ,('Taylor','Swift',1)
		   ,('Alanis','Morisette',1)
		   ,('Chris','Daughtry',1)
		   ,('Black Sabbath',null,2)
		   ,('The Cars',null,2)
		   ,('The Eagles',null,2)
		   ,('Patsy','Cline',1)
		   ,('Pearl Jam',null,2)
		   ,('Shinedown',null,2)
		   ,('Collective Soul',null,2)
		   ,('Five Finger Death Punch',null,2)
		   ,('Disturbed',null,2)
		   ,('Stone Temple Pilots',null,2)
		   ,('Breaking Benjamin',null,2)
		   ,('Seether',null,2)
		   ,('Audioslave',null,2)
		   ,('Temple of the Dog',null,2)
		   ,('Alice in Chains',null,2)
		   ,('Kansas',null,2);
GO

--Part F
INSERT INTO [dbo].[Disk_has_borrower]
           ([Disk_ID]
           ,[Borrower_ID]
           ,[Borrowed_date]
           ,[Returned_date])
     VALUES
           (2,4,'1/2/2019','2/26/2019')
		   ,(3,5,'11/12/2019','12/21/2019')
		   ,(3,6,'1/22/2019','2/22/2019')
		   ,(2,7,'7/22/2019','8/20/2019')
		   ,(5,2,'10/2/2019','12/20/2019')
		   ,(5,7,'4/2/2019','5/20/2019')
		   ,(5,7,'8/22/2019','12/20/2019')
		   ,(5,8,'11/2/2019','12/20/2019')
		   ,(11,14,'7/26/2019','12/20/2019')
		   ,(12,15,'8/25/2019','9/26/2019')
		   ,(13,15,'10/24/2019','11/20/2019')
		   ,(14,11,'10/23/2019','11/26/2019')
		   ,(15,11,'11/22/2019','12/2/2019')
		   ,(8,8,'3/21/2019','6/25/2019')
		   ,(15,12,'11/22/2019',null)
		   ,(9,4,'4/2/2019','7/20/2019')
		   ,(10,9,'1/2/2019','2/20/2019')
		   ,(4,3,'6/2/2019','2/22/2019')
		   ,(7,4,'1/22/2019','2/22/2019')
		   ,(2,14,'5/12/2019','6/2/2019');
GO

--Part G
INSERT INTO [dbo].[Disk_has_artist]
           ([Disk_ID]
           ,[Artist_ID])
     VALUES
            (1,1)
		   ,(2,1)
		   ,(3,3)
		   ,(4,4)
		   ,(5,6)
		   ,(6,8)
		   ,(7,8)
		   ,(8,8)
		   ,(8,7)
		   ,(8,6)
		   ,(9,12)
		   ,(10,12)
		   ,(11,18)
		   ,(12,16)
		   ,(13,15)
		   ,(14,15)
		   ,(15,12)
		   ,(15,15)
		   ,(16,16)
		   ,(17,17);
GO

--Lists disks that are on loan and have not been returned
--Part H
SELECT Borrower_ID AS Borrower_Id,
	   Disk_ID AS Disk_ID, 
	   Borrowed_date AS Borrowed_date, 
	   Returned_date AS Return_date
FROM Disk_has_borrower
WHERE Returned_date is null;


--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--Start of Week 4 Assignment 3/12/2019 
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

--Shows the disks in the database and any associated individual artists only
SELECT disk_name as 'Disk Name', 
       CONVERT(VARCHAR(10), Release_date, 101) AS 'Release Date',
	   A_first_name AS 'Artist First Name', 
	   A_last_name AS 'Artist Last Name'
	--SUBSTRING(A_first_name, 1, CHARINDEX(A_first_name, ' '))
FROM Disk
JOIN Disk_has_artist
	ON disk.Disk_ID = Disk_has_artist.Disk_ID
JOIN Artist
	ON Disk_has_artist.Artist_ID = Artist.Artist_ID
WHERE Artist_type_ID = 1
ORDER BY A_last_name, A_first_name, Disk_name;
GO


--Creates a view called "View_individual_artist" that shows artists' names and not group names.
CREATE VIEW View_individual_artist AS 
	SELECT Artist_ID, A_first_name, A_last_name
	FROM Artist
	WHERE Artist_type_ID = 1;
GO

SELECT A_first_name AS 'First Name',
       A_last_name AS 'Last Name'
FROM View_individual_artist 
ORDER BY A_last_name, A_first_name;


--Shows the disks in the database and any associated group artists only.
SELECT disk_name as 'Disk Name', CONVERT(VARCHAR(10), Release_date, 101) AS 'Release Date',
	   A_first_name AS 'Group Name'
FROM Disk
JOIN Disk_has_artist 
	ON disk.Disk_ID = Disk_has_artist.Disk_ID
JOIN Artist
	ON Disk_has_artist.Artist_ID = Artist.Artist_ID
WHERE Artist.Artist_ID NOT IN (SELECT Artist_ID FROM View_individual_artist);


--Shows which disks have been borrowed.
SELECT B_first_name AS 'First Name', 
       B_last_name AS 'Last Name', 
	   disk_name AS 'Disk Name', 
	   borrowed_date AS 'Borrowed Date',
	   Returned_date AS 'Returned  Date'
FROM Borrower b
JOIN Disk_has_borrower dhb
	ON b.Borrower_ID = dhb.Borrower_ID
JOIN Disk d
	ON dhb.Disk_ID = d.Disk_ID
ORDER BY Disk_name, B_first_name, B_last_name, Borrowed_date, Returned_date;


--Shows how many times each disk has been borrowed.
SELECT d.Disk_ID, Disk_name, 
	   COUNT(*) AS 'Times Borrowed'
FROM Disk d
JOIN Disk_has_borrower dhb
	ON dhb.Disk_ID = d.Disk_ID
GROUP BY d.Disk_ID, Disk_name
--HAVING COUNT(*) > 1
ORDER BY d.Disk_ID;


--Shows the disks outstanding or on-loan and how has each disk
SELECT Disk_name AS 'Disk Name', 
       Borrowed_date AS 'Borrowed Date', 
	   Returned_date AS 'Returned Date',
	   B_last_name AS 'Last Name'
FROM Disk d
JOIN Disk_has_borrower dhb
	ON d.Disk_ID = dhb.Disk_ID
JOIN Borrower b
	ON b.Borrower_ID = dhb.Borrower_ID
WHERE Returned_date IS NULL
ORDer BY Disk_name;