require "rubygems"
require "json"
require "net/https"

module Bacon
  module Addons
    class Asana
      attr_reader :api_key

      def initialize(key)
        find_or_create_by_api_key_and_workspace_id(key)
      end

protected

      #the standard for recording a asana object is: asana_*keyName*
      def find_or_create_by_api_key_and_workspace_id(api_key)
        stm = Bacon::DB.prepare "SELECT `object` FROM Bacon 
                                 WHERE`object` LIKE 'asana_%'"

        rs = stm.execute
        if rs.any?
          rs_hash = {}
          Array[*rs].each do |o|
            o1, o2 = o.to_s.split(':')
            rs_hash[o1] = o2
          end
          @api_key = rs_hash[:api_key]
        else
          Bacon::DB.execute "INSERT INTO Bacon (object) VALUES('asana_api_key:#{api_key}')"
        end
      end
    end
  end
end
