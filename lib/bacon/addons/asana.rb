require "rubygems"
require "json"
require "net/https"

module Bacon
  module Addons
    class Asana
      attr_reader :api_key

      def initialize(key)
        if find_by_api_key(key)
          #get asana data
        else
          create_by_api_key(key)
        end
      end

protected

      def find_by_api_key(api_key)
        query = Bacon::DB.prepare("SELECT `asana_key` FROM User
                                   WHERE `asana_key` = '#{api_key}'")
        results = query.execute![0]
        if results
          @api_key = results.first
          self
        else
          false
        end
      end

      def create_by_api_key(api_key)
        Bacon::DB.execute "INSERT INTO User (asana_key) VALUES('#{api_key}')"
      end

    end
  end
end
