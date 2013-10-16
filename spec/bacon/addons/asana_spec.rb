require 'spec_helper'

describe Bacon::Addons::Asana do
  it "should find or create api_key and workspace_id at initialization" do
    a = Bacon::Addons::Asana.new(1)
    stm = Bacon::DB.prepare "SELECT 1 FROM User 
                             WHERE `asana_key` = 1"

    rs = stm.execute
    Array[*rs].length.should eq 1
  end
end
