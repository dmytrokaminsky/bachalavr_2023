require "rails_helper"

RSpec.describe RoundsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/rounds").to route_to("rounds#index")
    end

    it "routes to #new" do
      expect(get: "/rounds/new").to route_to("rounds#new")
    end

    it "routes to #show" do
      expect(get: "/rounds/1").to route_to("rounds#show", id: "1")
    end
  end
end
