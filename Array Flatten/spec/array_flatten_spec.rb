require_relative '../array_flatten.rb'

describe "#array_flatten" do
  it "empty array" do
    expect(array_flatten([])).to eq []
  end

  it "flatten flat array of integers" do
    expect(array_flatten([1, 2, 3])).to eq [1, 2, 3]
  end

  context "flatten nested array of integers" do
    nested_array_level_1 = [1, 2, [3, 4], 5, 6, 7]
    nested_array_level_2 = [1, 2, [3, [4, 5]], 6, 7]
    array_start_with_nested =  [[1, 2, [3, 4]],[5, 6], 7]
    array_end_with_nested =  [1, 2, 3, [4, [5, [6], 7]]]

    result = [1, 2, 3, 4, 5, 6, 7]

    it "flatten nested array of integers :- level-1" do
      expect(array_flatten(nested_array_level_1)).to eq result
    end

    it "flatten nested array of integers :- level-2" do
      expect(array_flatten(nested_array_level_2)).to eq result
    end

    it "flatten nested array of integers start with array nested of nested" do
      expect(array_flatten(array_start_with_nested)).to eq result
    end

    it "flatten nested array of integers end with array nested of nested" do
      expect(array_flatten(array_end_with_nested)).to eq result
    end
  end

  context "fatten array of other types - receive Runtime Error" do
    array_contains_string = [1, 2, 3, 4, "hello", 5, 6, 7]
    nested_array_contains_string = [1, 2, [3, [4, "hello"]], 6, 7]
    nested_array_contains_float = [1, 2, [3, [4, 10.0]], 6, 7]

    it "flatten array contains string element" do
      expect { array_flatten(array_contains_string)}.to raise_error("Unexpected element type!")
    end

    it "flatten nested array contains string element inside nested cell" do
      expect { array_flatten(nested_array_contains_string)}.to raise_error("Unexpected element type!")
    end

    it "flatten nested array contains float element inside nested cell" do
      expect { array_flatten(nested_array_contains_float)}.to raise_error("Unexpected element type!")
    end
  end
end
