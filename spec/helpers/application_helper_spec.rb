require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "check plural" do
    it "with count equal 1" do
      expect(helper.plural(1, 'error_done')).to eq("1 помилка допущена")
    end

    it "with count equal 2" do
      expect(helper.plural(2, 'error_done')).to eq("2 помилки допущені")
    end

    it "with count equal 10" do
      expect(helper.plural(10, 'error_done')).to eq("10 помилок допущено")
    end
  end
end
