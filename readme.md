#	divvy data json api!

## get the data

1. download [the data](https://divvybikes.com/datachallenge)

2. download [postgres.app](http://postgresapp.com/)

3. prepare the data by removing the header rows from the csv files

4. make the tables:

	`create table stations (NAME varchar, LATITUDE double precision, LONGITUDE double precision, DPCAPACITY smallint);`

	`create table trips (TRIP_ID int, START_TIME timestamp, STOP_TIME timestamp, BIKE_BIKE_ID smallint, TRIP_DURATION varchar, FROM_STATION_ID varchar, FROM_STATION_NAME varchar, TO_STATION_ID varchar, TO_STATION_NAME varchar, USER_TYPE varchar, GENDER varchar, BIRTH_YEAR smallint);`

	`create table bikes (BIKE_ID int, TRIP_COUNT smallint, BIRTH_TRIP_ID int, DEATH_TRIP_ID int, BIRTH_TIME timestamp, DEATH_TIME timestamp, BIRTH_STATION varchar, DEATH_STATION varchar)`

5. load the data:

	`copy stations from '/path/path/path/Divvy_Stations_2013.csv' DELIMITERS ',' CSV;  `
	
	`copy trips from '/path/path/path/Divvy_Trips_2013.csv' DELIMITERS ',' CSV;  `

6. install the bundle: `bundle install`

7. uncomment the annotators in `app.rb`

8. run the app `bundle exec ruby app.rb`

## trips

### example `/trip/1`

	{
		trip_id: 1,
		start_time: "2013-06-27T12:11:00-05:00",
		stop_time: "2013-06-27T12:16:00-05:00",
		trip_duration: "316",
		from_station_name: "Michigan Ave & Oak St",
		to_station_name: "Larrabee St & Menomonee St",
		user_type: "Customer",
		birth_year: null,
		bike_bike_id: 480
	}

### `/trips`

*takes way too long please don't try this*

### `/trip/:trip_id`

## stations

### example: `/station/Michigan Ave & Oak St`

	{
		station_id: 61,
		name: "Michigan Ave & Oak St",
		latitude: 41.90096039,
		longitude: -87.62377664,
		dpcapacity: 15
	}

### `/stations`

### `/station/:station_name`

### `/station/:station_name/trips`

all trips from and to a station

## bikes

### example: `/bike/1`

	{
		bike_id: 1,
		trip_count: 397,
		birth_trip_id: 407,
		death_trip_id: 758359,
		birth_time: "2013-06-28T18:52:00-05:00",
		death_time: "2013-12-20T10:27:00-06:00",
		birth_place: "McCormick Place",
		death_place: "LaSalle St & Illinois St"
	}

### `/bikes`

### `/bike/:bike_id`

### `/bike/:bike_id/trips`