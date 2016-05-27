# -------------------------------------------------------------------------------------
# We have some customer records in a text file (customers.json) -- one customer per
# line, JSON-encoded. We want to invite any customer within 100km of our
# Dublin office for some food and drinks on us.
# Write a program that will read the full list of customers and output
# the names and user ids of matching customers (within 100km),
# sorted by User ID (ascending).
# -------------------------------------------------------------------------------------


#This main Class of this program to invite customers lists within given
# radius by parsing file that contains customer JSON per line.

# Usage :-

# customer_invitation =  CustomerInvitation.new(file: input_file)
# input
#  file    -   required
#  lat     -   optional, default value is 53.3381985
#  long    -   optional, default value is -6.2592576
#  radius  -   optional, default value is 100 KM, accepted it as KM

# c_i.print_customers  # will print customer details as

    # User ID -4, Name - Shamith C
    # User ID -4, Name - Ian Kehoe
    # User ID -5, Name - Nora Dempsey
    # User ID -6, Name - Theresa Enright
    # User ID -8, Name - Eoin Ahearn

    #  Thanks for using this service.


# If input file contains error, will print reason along with line no

    # Unable to process next due to following errors in your input file

    # Key latitude not present or Value is Invalid at line no:- 22
    # Key longitude not present or Value is Invalid at line no:- 28
    # Key user_id not present or Value is Invalid at line no:- 33
    # 757: unexpected token at 'asds
    # ' at line no 34

require_relative 'import_customer'
require_relative 'great_circle_distance'

class CustomerInvitation

  include GreatCircleDistance

  attr_reader :invitee_list

  def initialize(file:, lat: 53.3381985, long: -6.2592576, radius: 100)
    @source_lat = lat.to_f
    @source_long = long.to_f
    @radius = radius.to_f
    @customer_importer = ImportCustomer.new(file.to_s)
  end

  def print_customers
    invite_customers_within_radius
    return if @invitee_list.nil?

    puts "Customer Details within #{@radius} KM of [#{@source_lat}, #{@source_long}]\n\n"
    @invitee_list.each do |customer|
      puts print_customer(customer)
    end
    puts "\n Thanks for using this service."
  end

  def invite_customers_within_radius
    if !@customer_importer.file_exists?
      puts "File not found, Please try again."
      return "File not found, Please try again."
    end

    print_error_messages and return if !load_customers.errors.empty?

    @invitee_list = []
    load_customers.customers.each do |customer|
      distance =  distance(@source_lat, @source_long, customer["latitude"], customer["longitude"])
      if distance <= @radius
        @invitee_list << customer
      end
    end
    sort_by_user_id
  end

  private

  def load_customers
    @load_customer ||= @customer_importer.load_customers
  end

  def sort_by_user_id
    @invitee_list.sort_by! { |customer| customer["user_id"] }
  end

  def print_customer customer
    "User ID -#{customer["user_id"]}, Name - #{customer["name"]} \n"
  end

  def print_error_messages
    puts "Unable to process next due to following errors in your input file \n\n"
    @customer_importer.errors.each do |error|
      puts "#{error} \n"
    end
  end
end
