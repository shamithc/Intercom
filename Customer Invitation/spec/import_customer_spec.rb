require_relative '../import_customer.rb'

describe ImportCustomer do
  context "File contains valid JSON" do
    let(:valid_file) {File.expand_path('fixtures/valid_customers.txt', File.dirname(__FILE__))}

    it "Contains valid json each line" do
      import_customers = ImportCustomer.new(valid_file)
      expect(import_customers.file_exists?).to eq true
      import_customers.load_customers
      expect(import_customers.errors).to eq []
    end
  end

  context "File Contains Invalid JSON" do

    let(:lat_missing) {
      File.expand_path('fixtures/lat_missing.txt', File.dirname(__FILE__))
    }

    let(:latvalue_invalid) {
      File.expand_path('fixtures/latvalue_invalid.txt', File.dirname(__FILE__))
    }

    let(:long_missing) {
      File.expand_path('fixtures/long_missing.txt', File.dirname(__FILE__))
    }

    let(:longvalue_invalid) {
      File.expand_path('fixtures/longvalue_invalid.txt', File.dirname(__FILE__))
    }

    let(:user_id_missing) {
      File.expand_path('fixtures/user_id_missing.txt', File.dirname(__FILE__))
    }

    let(:user_id_value_invalid) {
      File.expand_path('fixtures/user_id_value_invalid.txt', File.dirname(__FILE__))
    }

    let(:lat_message){
      "Key latitude not present or Value is Invalid at line no:- 1"
    }

    let(:long_message){
      "Key longitude not present or Value is Invalid at line no:- 1"
    }

    let(:user_message){
      "Key user_id not present or Value is Invalid at line no:- 1"
    }

    it "Latitude Missing from JSON" do
      import_customers = ImportCustomer.new(lat_missing)
      import_customers.load_customers
      expect(import_customers.errors).to eq [lat_message]
      expect(import_customers.errors.length).to eq 1
    end

    it "Latitude value Invalid" do
      import_customers = ImportCustomer.new(latvalue_invalid)
      import_customers.load_customers
      expect(import_customers.errors).to eq [lat_message]
      expect(import_customers.errors.length).to eq 1
    end

    it "Longitude Missing from JSON" do
      import_customers = ImportCustomer.new(long_missing)
      import_customers.load_customers
      expect(import_customers.errors).to eq [long_message]
      expect(import_customers.errors.length).to eq 1
    end

    it "Longitude value invalid" do
      import_customers = ImportCustomer.new(longvalue_invalid)
      import_customers.load_customers
      expect(import_customers.errors).to eq [long_message]
      expect(import_customers.errors.length).to eq 1
    end

    it "User id Missing from JSON" do
      import_customers = ImportCustomer.new(user_id_missing)
      import_customers.load_customers
      expect(import_customers.errors).to eq [user_message]
      expect(import_customers.errors.length).to eq 1
    end

    it "User id is invalid" do
      import_customers = ImportCustomer.new(user_id_value_invalid)
      import_customers.load_customers
      expect(import_customers.errors).to eq [user_message]
      expect(import_customers.errors.length).to eq 1
    end
  end
end
