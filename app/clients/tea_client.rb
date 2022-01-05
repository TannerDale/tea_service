require 'faraday/net_http'

class TeaClient
  class << self
    def fetch(url)
      parse(conn.get(url))
    end

    private

    def conn
      Faraday.default_adapter = :net_http
      Faraday.new('https://tea-api-vic-lo.herokuapp.com')
    end

    def parse(response)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
