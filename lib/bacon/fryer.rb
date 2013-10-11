require 'em-websocket'

module Bacon
  class Fryer
    def self.log(text)
      Bacon::DB.execute "INSERT INTO Bacon (object) VALUES('fryer_log@#{Time.now}: #{text}')"
      puts text
    end

    def self.do_eet
      EM.run do
        Fryer.start_websocket_server
      end
    end

    def self.start_websocket_server
      Fryer.log 'Booting up bacon server'
      EM::WebSocket.run(:host => "localhost", :port => 8080) do |ws|
        ws.onopen { |handshake|
          Fryer.log "Someone wants crispy bacon"
          ws.send "Welcome, Bacon Lover!"
        }

        ws.onmessage { |msg|
          Fryer.log "Recieved message: #{msg}"
        }
      end
    end
  end
end
