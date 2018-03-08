require 'yaml'
require 'uri'

module Cedar2Triplestore
  class FetchFolders

    def initialize
      @cedar ||= YAML.safe_load(File.open('cedar.yml').read)
      @api_key = @cedar['apiKey']
      @post_url = @cedar['postUrl']
    end

    def contents
      if @api_key.nil?
        'Please put your API key in the cedar.yml file!'
      else
        post(content_uris(json(folder_url)))
      end
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
      r = @cedar['resourceUrl']
      f = URI.encode_www_form_component(@cedar['folderUrl'])
      u = @cedar['folderUuid']
      params = "resource_types=instance,template,folder,element"
      "#{r}#{f}#{u}/contents?#{params}"
    end
  end
end
