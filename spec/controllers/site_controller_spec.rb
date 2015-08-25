require 'rails_helper'

RSpec.describe SiteController, type: :controller do

  render_views
  describe "results" do
    before do
       mock_search = double(Search, photos: [['flickr.com/image_small.png','flickr.com/image_big.png'],['google.com/image_small.jpg','google.com_big.jpg']])
       expect(Search).to receive(:new).with("Dennis").and_return(mock_search)
    end

    it "succeeds" do
      get :results, :search => "Dennis"
      expect(response).to be_success
    end

    it "fetches photos from flickr" do
      get :results, :search => "Dennis"
      expect(assigns[:results]).to eq [['flickr.com/image_small.png','flickr.com/image_big.png'],['google.com/image_small.jpg','google.com_big.jpg']]
    end
  end



end
