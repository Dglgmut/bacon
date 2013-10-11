require 'spec_helper'

describe Bacon::Fryer do
  before :each do
    EM::WebSocket.stub(:run).and_return(nil)
    EM.stub(:run).and_return(Bacon::Fryer.start_websocket_server)
  end

  it "should log a message" do
    Bacon::Fryer.do_eet

    stm = Bacon::DB.prepare "SELECT `object` FROM Bacon LIMIT 1"
    rs = stm.execute
    rs.first.join('\s').should =~ /fryer_log/
  end
end
