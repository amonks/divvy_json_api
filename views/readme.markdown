#	divvy data json api!

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