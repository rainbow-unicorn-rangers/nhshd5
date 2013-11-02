class Place < ActiveRecord::Base
  attr_accessible :description, :latitude, :longitude, :name, :place_type

  @client_id     = 'MIWYYAX3URRPFV3OJTT041F5QIIE1E5GRDNAQ0CLFACR5GHS'
  @client_secret = 'SPQB2PD13XMQVTWT0KFJGORE2OBBOARCCPR5RI0DT0JTSVBI'

  def self.find_from_foursquare(lat = nil, long = nil)
    client = Foursquare2::Client.new(:client_id => @client_id, :client_secret => @client_secret)

    locations = []

    @venues = client.search_venues(ll: "#{lat}, #{long}")
    @venues.groups[0].items.each do |venue|

      geo = "#{venue.location.lat},#{venue.location.lng}"

      location = { name: venue.name, geo: geo }
      locations << location
    end

    locations
  end

end