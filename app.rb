# Require the bundler gem and then call Bundler.require to load in all gems
# listed in Gemfile.
require 'open-uri'
require 'bundler'
Bundler.require

DataMapper.setup(:default, "postgres://localhost:5432/ajm")

# Define a simple DataMapper model.
class Trip
  include DataMapper::Resource

  property :trip_id, Serial, :key => true
  property :start_time, DateTime
  property :stop_time, DateTime
  # property :bike_id, Integer
  property :trip_duration, String
  property :from_station_name, String
  property :to_station_name, String
  property :user_type, String
  property :birth_year, Integer

  # belongs_to :from_station, 'Station',
  #   :parent_key => [ :trip_id ],
  #   :child_key => [ :from_station_name ]

  # belongs_to :to_station, 'Station',
  #   :parent_key => [ :trip_id ],
  #   :child_key => [ :to_station_name ]

  belongs_to :bike, 'Bike'
end

class Station
  include DataMapper::Resource

  property :station_id, Serial
  property :name, Text, :key => true
  property :latitude, Float
  property :longitude, Float
  property :dpcapacity, Integer

  # has n, :trips, 'Trip',
  #   :parent_key => [:name],
  #   :child_key => [:trip_id]
end

class Bike
  include DataMapper::Resource
  property :bike_id, Integer, :key => true
  property :trip_count, Integer
  property :birth_trip_id, Integer
  property :death_trip_id, Integer
  property :birth_time, DateTime
  property :death_time, DateTime
  property :birth_place, String
  property :death_place, String
  has n, :trips
end


# Finalize the DataMapper models.
DataMapper.finalize

# Tell DataMapper to update the database according to the definitions above.
DataMapper.auto_upgrade!


get '/' do
  haml :index
end

get '/stations' do
  @stations = Station.all
  @stations.to_json
end
get '/station/:station_name/trips' do
  @station = Station.first(:name => params[:station_name])
  @trips = Trip.all(:from_station_name => @station.name) + Trip.all(:to_station_name => @station.name)
  @trips.to_json
end
get '/station/:station_name' do
  @station = Station.first(:name => params[:station_name])
  @station.to_json
end

get '/bikes' do
  @bikes = Bike.all
  @bikes.to_json
end
get '/bike/:bike_id/trips' do
  @bike = Bike.get(params[:bike_id])
  @trips = Trip.all(:bike_bike_id => @bike.bike_id, :order => [ :stop_time.asc ])
  @trips.to_json
end
get '/bike/:bike_id' do
  @bike = Bike.get(params[:bike_id])
  @bike.to_json
end

get '/trips' do
  @trips = Trip.all
  @trips.to_json
end
get '/trip/:trip_id' do
  @trip = Trip.get(params[:trip_id])
  @trip.to_json
end



# annotators

# make bike table
def make_bikes(range)
    range.each do |i|
        @trip = Trip.get(i)
        @bike = Bike.first_or_create(:bike_id => @trip.bike_id)
        @trips = Trip.all(:bike_bike_id => @bike.bike_id)

        @bike.update(
          :trip_count => @trips.length,
          :birth_trip_id => @trips.first.trip_id,
          :death_trip_id => @trips.last.trip_id,
          :birth_time => @trips.first.start_time,
          :death_time => @trips.last.stop_time,
          :birth_place => @trips.first.from_station_name,
          :death_place => @trips.last.to_station_name
        )

        if (i % 10 == 0)
            puts i
        end
    end
end

# update bike table
def update_bikes(range)
    range.each do |i|
        if ( @bike = Bike.first_or_create(:bike_id => i) )
          @trips = Trip.all(:bike_bike_id => @bike.bike_id)

          @bike.update(
            :trip_count => @trips.length,
            :birth_trip_id => @trips.first.trip_id,
            :death_trip_id => @trips.last.trip_id,
            :birth_time => @trips.first.start_time,
            :death_time => @trips.last.stop_time,
            :birth_place => @trips.first.from_station_name,
            :death_place => @trips.last.to_station_name,
          )
        end

        if (i % 10 == 0)
            puts i
        end
    end
end

# make_bikes(1..Trip.last.trip_id)
# update_bikes(1..Bike.last.bike_id)
