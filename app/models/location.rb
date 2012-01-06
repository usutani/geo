class Location < ActiveRecord::Base
  attr_accessible :address, :latitude, :longitude
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?

  def map_string
   str =  "http://maps.google.com/maps/api/staticmap"
   str += "?size=450x300"
   str += "&sensor=false"
   str += "&zoom=10"
   str += "&markers="
   str += marker_string

   for location in nearbys(30)
     str += "|"
     str += location.marker_string
   end

   return str
  end

  def marker_string
    str = latitude.to_s
    str += ","
    str += longitude.to_s
    return str
  end
end
