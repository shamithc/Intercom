require_relative '../customer_invitation.rb'

describe CustomerInvitation do
  context "Invite Customers" do
    let(:valid_file) {File.expand_path('fixtures/valid_customers.txt', File.dirname(__FILE__))}
    let(:invitee_list) {
      [
        {"latitude"=>53.2451022, "user_id"=>4, "name"=>"Ian Kehoe", "longitude"=>-6.238335},
        {"latitude"=>52.986375, "user_id"=>12, "name"=>"Christina McArdle", "longitude"=>-6.043701}
      ]
    }

    it "Load valid customer path" do
      customer_invitation = CustomerInvitation.new(file: valid_file)
      customer_invitation.invite_customers_within_radius
      expect(customer_invitation.invitee_list).to eq invitee_list
      expect(customer_invitation.invitee_list.length).to eq 2
    end

    it "Provide radius of 10 KM" do
      customer_invitation = CustomerInvitation.new(file: valid_file, radius: 15)
      customer_invitation.invite_customers_within_radius
      expect(customer_invitation.invitee_list.length).to eq 1
    end

    it "provide lat, long and radius" do
      customer_invitation = CustomerInvitation.new(file: valid_file, lat: 10.0142648, long: 76.3579287, radius: 15)
      customer_invitation.invite_customers_within_radius
      expect(customer_invitation.invitee_list).to eq []
      expect(customer_invitation.invitee_list.length).to eq 0
    end

    it "Invalid file path" do
      customer_invitation = CustomerInvitation.new(file: "in_valid_pat.txt")
      expect(customer_invitation.invite_customers_within_radius).to eq "File not found, Please try again."
      expect(customer_invitation.invitee_list).to eq nil
    end

    it "Sorted by User ID (ascending)" do
      customer_invitation = CustomerInvitation.new(file: valid_file)
      customer_invitation.invite_customers_within_radius
      user_ids = customer_invitation.invitee_list.collect{|item| item["user_id"]}
      expect(user_ids).to eq [4, 12]
    end
  end
end
