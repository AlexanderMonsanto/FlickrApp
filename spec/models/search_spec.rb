require 'rails_helper'

RSpec.describe Search, type: :model do
  describe "initialization" do
    it "takes a query" do
      search = Search.new("Newton")

      expect(search.query).to eq("Newton")
    end
  end

  describe "photos being received" do
    let(:mock_flickr) { double(FlickRaw::Flickr).as_null_object }

    let(:search) { Search.new("Thor") }

    before do
      expect(search).to receive(:flickr).and_return(mock_flickr)
      expect(mock_flickr).to receive(:search).with(hash_including(:text => "Thor")).and_return(search_results)
    end

    context "with no search results from flickr" do
      let(:search_results) { [] }
      it "returns and empty array" do
        expect(search.photos).to eq([])
      end
    end

    context "with search results" do
      let(:search_results) { [double(:farm => "A", :server => "Wutang", :id => "Passport", :secret => "Victoria"), double.as_null_object] }

      it "returns an array of big and small img url tuple" do
        expect(search.photos[0]).to eq(
          ["https://farmA.staticflickr.com/Wutang/Passport_Victoria_s.jpg", "https://farmA.staticflickr.com/Wutang/Passport_Victoria_b.jpg"]
          )
      end

      it "returns a tuple for each search result" do
        expect(search.photos.length).to eq(2)
      end
    end
  end
end
