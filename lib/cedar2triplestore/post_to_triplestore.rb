require 'faraday'

module Cedar2Triplestore
  class PostToTriplestore
    extend Faraday
    attr_reader :path

    def post(json, url)
      response ||= begin
        conn = Faraday.new(url: url)
        response = conn.post do |req|
          req.headers['Content-Type'] = 'application/ld+json'
          req.body = json
        end
        return empty_response(response.body) unless response.success?
        response
      rescue Faraday::Error => e
        empty_response(e)
      end
    end

    def empty_response(error = nil)
      puts "HTTP PostToTriplestore failed with: #{error}"
    end
  end
end
