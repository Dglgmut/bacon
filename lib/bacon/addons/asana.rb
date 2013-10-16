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

      def get_user_info
        # issue the request
        body = self.http_request("https://app.asana.com/api/1.0/users/me")

        # output
        if body['errors']
          raise "Server returned an error: #{body['errors'][0]['message']}"
        else
          body
        end
      end

protected

      def http_request(uri_string)
        uri = URI.parse(uri_string)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER

        # set up the request
        header = {
          "Content-Type" => "application/json"
        }

        req = Net::HTTP::Get.new(uri.path, header)
        req.basic_auth(self.api_key, '')

        res = http.start { |http| http.request(req) }
        JSON.parse(res.body)
      end

      def find_by_api_key(api_key)
        query = Bacon::DB.prepare("SELECT `asana_key` FROM users
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
        Bacon::DB.execute "INSERT INTO users (asana_key) VALUES('#{api_key}')"
        get_user_info
      end
    end
  end
end
