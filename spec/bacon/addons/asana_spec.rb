require 'spec_helper'

describe Bacon::Addons::Asana do
  it "should find or create api_key and workspace_id at initialization" do
    a = Bacon::Addons::Asana.new('im_a_key')
    stm = Bacon::DB.prepare "SELECT `asana_key` FROM User
                             WHERE `asana_key` = 'im_a_key'"

    rs = stm.execute
    rs.next.first.should eq 'im_a_key'
  end
end
