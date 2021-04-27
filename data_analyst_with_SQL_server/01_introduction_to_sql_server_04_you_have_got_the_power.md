---
title: Introduction to SQL Server
subtitle: You've got the power
---

# Create tables

```
-- Create the table
CREATE TABLE results (
	-- Create track column
	track varchar(200),
    -- Create artist column
	artist varchar(120),
    -- Create album column
	album varchar(160),
	);
```

```
-- Create the table
CREATE TABLE results (
	-- Create track column
	track VARCHAR(200),
    -- Create artist column
	artist VARCHAR(120),
    -- Create album column
	album VARCHAR(160),
	-- Create track_length_mins
	track_length_mins INT,
	);
```

```
-- Create the table
CREATE TABLE results (
	-- Create track column
	track VARCHAR(200),
    -- Create artist column
	artist VARCHAR(120),
    -- Create album column
	album VARCHAR(160),
	-- Create track_length_mins
	track_length_mins INT,
	);

-- Select all columns from the table
SELECT
  track,
  artist,
  album,
  track_length_mins
FROM
  results;
```

# Insert

```
-- Create the table
CREATE TABLE tracks(
	-- Create track column
	track varchar(200),
    -- Create album column
  	album varchar(160),
	-- Create track_length_mins column
	track_length_mins INT
);
-- Select all columns from the new table
SELECT
  *
FROM
  tracks;
```

```
-- Create the table
CREATE TABLE tracks(
  -- Create track column
  track VARCHAR(200),
  -- Create album column
  album VARCHAR(160),
  -- Create track_length_mins column
  track_length_mins INT
);
-- Complete the statement to enter the data to the table         
INSERT INTO tracks
-- Specify the destination columns
(track, album, track_length_mins)
-- Insert the appropriate values for track, album and track length
VALUES
  ('Basket Case', 'Dookie', 3);
-- Select all columns from the new table
SELECT
  *
FROM
  tracks;
```

# Update

```
-- Run the query
SELECT
  title
FROM
  album
WHERE
  album_id = 213;
-- UPDATE the album table
UPDATE
  album
-- SET the new title    
SET
  title = 'Pure Cult: The Best Of The Cult'
WHERE album_id = 213;
```

```
-- Select the album
SELECT
  title
FROM
  album
WHERE
  album_id = 213;
-- UPDATE the title of the album
UPDATE
  album
SET
  title = 'Pure Cult: The Best Of The Cult'
WHERE
  album_id = 213;
-- Run the query again
SELECT
  title
FROM
  album
WHERE
  album_id = 213;
```

# Delete

```
-- Run the query
SELECT
  *
FROM
  album
```

```
-- Run the query
SELECT
  *
FROM
  album
  -- DELETE the record
DELETE FROM
  album
WHERE
  album_id = 1
  -- Run the query again
SELECT
  *
FROM
  album;
```

# DECLARE and SET a variable

```
-- Declare the variable @region, and specify the data type of the variable
DECLARE @region VARCHAR(10)
```

```
-- Declare the variable @region
DECLARE @region VARCHAR(10)

-- Update the variable value
SET @region = 'RFC'
```

```
-- Declare the variable @region
DECLARE @region VARCHAR(10)

-- Update the variable value
SET @region = 'RFC'

SELECT description,
       nerc_region,
       demand_loss_mw,
       affected_customers
FROM grid
WHERE nerc_region = @region;
```

# Declare multiple variables

```
-- Declare @start
DECLARE @start DATE

-- SET @start to '2014-01-24'
SET @start = '2014-01-24'
```

```
-- Declare @start
DECLARE @start DATE

-- Declare @stop
DECLARE @stop DATE

-- SET @start to '2014-01-24'
SET @start = '2014-01-24'

-- SET @stop to '2014-07-02'
SET @stop = '2014-07-02'
```

```
-- Declare @start
DECLARE @start DATE

-- Declare @stop
DECLARE @stop DATE

-- Declare @affected
DECLARE @affected INT

-- SET @start to '2014-01-24'
SET @start = '2014-01-24'

-- SET @stop to '2014-07-02'
SET @stop  = '2014-07-02'

-- Set @affected to 5000
SET @affected = 5000
```

```
-- Declare your variables
DECLARE @start DATE
DECLARE @stop DATE
DECLARE @affected INT;
-- SET the relevant values for each variable
SET @start = '2014-01-24'
SET @stop  = '2014-07-02'
SET @affected =  5000 ;

SELECT
  description,
  nerc_region,
  demand_loss_mw,
  affected_customers
FROM
  grid
-- Specify the date range of the event_date and the value for @affected
WHERE event_date BETWEEN @start AND @stop
AND affected_customers >= @affected;
```

# Ultimate Power

```
SELECT  album.title AS album_title,
  artist.name as artist,
  MAX(track.milliseconds / (1000 * 60) % 60 ) AS max_track_length_mins
-- Name the temp table #maxtracks
INTO #maxtracks
FROM album
-- Join album to artist using artist_id
INNER JOIN artist ON album.artist_id = artist.artist_id
-- Join track to album using album_id
INNER JOIN track ON album.album_id = track.album_id
GROUP BY artist.artist_id, album.title, artist.name,album.album_id
-- Run the final SELECT query to retrieve the results from the temporary table
SELECT album_title, artist, max_track_length_mins
FROM  #maxtracks
ORDER BY max_track_length_mins DESC, artist;
```
