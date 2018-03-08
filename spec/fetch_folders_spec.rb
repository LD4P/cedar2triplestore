RSpec.describe Cedar2Triplestore::FetchFolders do
  describe 'initializing variables from yaml' do
    let(:ff) { Cedar2Triplestore::FetchFolders.new }
    let(:cedar) { ff.instance_variable_get(:@cedar) }

    it 'reads the yaml file' do
      expect(ff).to be_present
    end

    it 'gets the variables from the yaml-created hash' do
      expect(cedar['folderUuid']).to be_present
      expect(cedar['postUrl']).to be_present
      expect(cedar['folderUrl']).to eq 'https://repo.metadatacenter.org/folders/'
      expect(cedar['resourceUrl']).to eq 'https://resource.metadatacenter.org/folders/'
    end

    it 'creates a url for fetching cedar folders' do
      expect(ff.send(:folder_url)).to include(cedar['folderUuid'])
      expect(ff.send(:folder_url)).to include(cedar['resourceUrl'])
      expect(ff.send(:folder_url))
        .to include(URI.encode_www_form_component(cedar['folderUrl']))
    end
  end

  describe 'gets the content uris' do
    let(:ff) { Cedar2Triplestore::FetchFolders.new }
    let(:json) { File.read('spec/fixtures/CEDAR GEODATA 01.json') }

    before do
      allow(ff).to receive(:content_uris).and_return(json)
    end

    it 'gets the content uri' do
      expect(ff.send(:content_uris, json['resources'])).to include('https://repo.metadatacenter.org/template-instances/b8364ceb-438b-49af-828a-e2af29a3acd3')
    end

    it 'returns a message if there is no api key' do
      expect(ff.contents).to eq 'Please put your API key in the cedar.yml file!'
    end
  end
end
