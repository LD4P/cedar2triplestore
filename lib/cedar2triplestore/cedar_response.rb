require 'faraday'

module Cedar2Triplestore
  class CedarResponse
    extend Faraday
    attr_reader :folder_url
    attr_reader :api_key

    def response(url, key)
      response ||= begin
        conn = Faraday.new(url: url)

        response = conn.get do |req|
          req.headers['Authorization'] = "apiKey #{key}"
        end

        return empty_response(response.body) unless response.success?
        response
      rescue Faraday::Error => e
        empty_response(e)
      end
    end

    def empty_response(error = nil)
      puts "HTTP GET for FetchFolders failed with: #{error}"
    end
  end
end
