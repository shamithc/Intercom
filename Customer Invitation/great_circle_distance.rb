# This module calculate distance between two points
# Used Great-circle distance formula for finding distance
# between two points

module GreatCircleDistance

  EARTH_RADIUS = 6371.0

  # Return distance between two points
  def distance(lat1, lon1, lat2, lon2)
    distance = Math::acos(
      Math::sin(to_radians(lat1))*Math::sin(to_radians(lat2)) +
      Math::cos(to_radians(lat1))*Math::cos(to_radians(lat2)) *
      Math::cos(to_radians(lon2-lon1))
    ) * EARTH_RADIUS
    distance.round(2)
  end

  # degree to radians
  def to_radians(degrees)
    degrees * Math::PI / 180.0
  end
end
