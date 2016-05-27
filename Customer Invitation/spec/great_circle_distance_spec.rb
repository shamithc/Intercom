require_relative '../great_circle_distance.rb'

describe GreatCircleDistance do
  include GreatCircleDistance

  it "Distance between two points:  [53.3381985, -6.2592576] and [52.986375, -6.238335] should 39.15." do
  	expect(distance(53.3381985, -6.2592576, 52.986375, -6.238335)).to eq  39.15
  end
end
