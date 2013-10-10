
require "bacon/version"
module Bacon
  # Your bacon goes here...
  class Fryer
    require 'em-websocket'

    def self.do_eet
      EM.run {
        puts 'Booting up bacon server'
        EM::WebSocket.run(:host => "localhost", :port => 8080) do |ws|
          ws.onopen { |handshake|
            puts "Someone wants crispy bacon"
            ws.send "Welcome, Bacon Lover!"
          }

          ws.onmessage { |msg|
            puts "Recieved message: #{msg}"
          }
        end
      }
    end
  end
end
