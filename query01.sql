-- Active: 1707329957355@@localhost@5432@m509A1
/*
    Example: How many bike trips in Q3 2021. Name the resulting column
    num_trips.
*/

-- 300,432 trips

-- Enter your SQL query here
select count(*) as num_trips
from indego.trips_2021_q3