# This class is responsible for load customers data by parsing input file that
# passed from CustomerInvitation class.

require 'json'

class ImportCustomer

  attr_reader :customers, :errors

  def initialize(file)
    @input_file = file
    @customers = []
    @errors = []
  end

  # load customers into customers array by parsing each line of
  # input file
  def load_customers
    File.foreach(@input_file).with_index do |line, line_num|
      begin
        customer_json = JSON.parse(line)
        @customers << validate_customer_json(customer_json, line_num)
      rescue JSON::ParserError => e
        @errors << "#{e.message} at line no #{line_num + 1}"
      end
    end
    self
  end

  def file_exists?
    File.exist? @input_file
  end

  private

  # Check whether latitude, longitude and user_id
  # is valid and exists in Given JSON input
  def validate_customer_json(customer_json, line_no)
  	# check latitude
    if valid_latitude?(customer_json)
      customer_json["latitude"] = customer_json["latitude"].to_f
    else
      @errors << error_message("latitude", line_no)
    end

    # check longitude
    if valid_longitude?(customer_json)
      customer_json["longitude"] = customer_json["longitude"].to_f
    else
      @errors << error_message("longitude", line_no)
    end

    # Check user id
    if valid_user_id?(customer_json)
      customer_json["user_id"] = customer_json["user_id"].to_i
    else
      @errors << error_message("user_id", line_no)
    end

    customer_json
  end

  def valid_latitude? customer_json
    has_key?(customer_json, "latitude") and is_number?(customer_json, "latitude")
  end

  def valid_longitude? customer_json
    has_key?(customer_json, "longitude") and is_number?(customer_json, "longitude")
  end

  def valid_user_id? customer_json
    has_key?(customer_json, "user_id") and is_number?(customer_json, "user_id")
  end

  # Check given key is present
  def has_key?(customer_json, key)
    customer_json.has_key? key
  end

  # Check value is a number
  def is_number? customer_json, key
    value = customer_json[key]
    value.to_f.to_s == value.to_s || value.to_i.to_s == value.to_s
  end

  def error_message(attribute, line_no)
    "Key #{attribute} not present or Value is Invalid at line no:- #{line_no + 1}"
  end

end
