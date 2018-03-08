require 'yaml'
require 'uri'

module Cedar2Triplestore
  class FetchFolders

    def initialize
      @cedar ||= YAML.load(File.open('cedar.yml').read)
      @api_key = @cedar['apiKey']
      @post_url = @cedar['postUrl']
    end

    def contents
      @api_key.nil? ? (return 'Please put your API key in the cedar.yml file!') : post(content_uris(json(folder_url)))
    end

    private

    def post(content_uris)
      content_uris.uniq.each do |u|
        PostToTriplestore.new.post(json(u).to_json, @post_url)
      end
    end

    def content_uris(json)
      content_uris = []
      json['resources'].each do |child|
        content_uris << child['@id']
      end
      content_uris
    end

    def json(url)
      JSON.parse(CedarResponse.new.response(url, @api_key).body)
    end

    def folder_url
       "#{@cedar['resourceUrl']}#{URI.encode(@cedar['folderUrl'], /[:\/]/)}#{@cedar['folderUuid']}/contents?resource_types=instance,template,folder,element"
    end
  end
end
