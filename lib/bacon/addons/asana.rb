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

      def find_or_create_by_api_key_and_workspace_id(api_key)
        stm = Bacon::DB.prepare "SELECT `asana_key` FROM User 
                                 WHERE`asana_key` = '#{api_key}'"

        rs = stm.execute
        if rs.any?
          rs_hash = {}
          Array[*rs].each do |o|
            o1, o2 = o.to_s.split(':')
            rs_hash[o1] = o2
          end
          @api_key = rs_hash[:api_key]
        else
          Bacon::DB.execute "INSERT INTO User (asana_key) VALUES('#{api_key}')"
        end
      end
    end
  end
end
