class Search
  def initialize query
    @query = query
  end

  def query
    @query
  end

  def photos
    list = flickr.photos.search :text => query, :sort => 'relevance'

    list.map do |photo|
      [FlickRaw.url_s(photo),
        FlickRaw.url_b(photo)]
    end
  end
end




