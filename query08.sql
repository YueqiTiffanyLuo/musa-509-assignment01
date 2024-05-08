- Active: 1707329957355@@localhost@5432@m509A1
/*
    Give the five most popular starting stations across all years between 7am
    and 9:59am.

    Your result should have 5 records with three columns, one for the station id
    (named `station_id`), one for the point geography of the station (named
    `station_geog`), and one for the number of trips that started at that
    station (named `num_trips`).
*/

-- Enter your SQL query here

WITH
trips_2021_q3 AS (
    SELECT
        start_station AS station_id,
        ST_GEOMFROMTEXT('POINT(' || start_lon::text || ' ' || start_lat::text || ')')::geography AS station_geog
    FROM indego.trips_2021_q3
    WHERE EXTRACT(HOUR FROM start_time) >= 7 AND EXTRACT(HOUR FROM start_time) < 10
),
trips_2022_q3 AS (
    SELECT
        start_station AS station_id,
        ST_GEOMFROMTEXT('POINT(' || start_lon::text || ' ' || start_lat::text || ')')::geography AS station_geog
    FROM indego.trips_2022_q3
    WHERE EXTRACT(HOUR FROM start_time) >= 7 AND EXTRACT(HOUR FROM start_time) < 10
),
combined_trips AS (
    SELECT * FROM trips_2021_q3
    UNION ALL
    SELECT * FROM trips_2022_q3
)

SELECT
    station_id,
    station_geog,
    COUNT(*) AS num_trips
FROM combined_trips
GROUP BY station_id, station_geog
ORDER BY num_trips DESC
LIMIT 5;











/*
    Hint: Use the `EXTRACT` function to get the hour of the day from the
    timestamp.
*/
