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
