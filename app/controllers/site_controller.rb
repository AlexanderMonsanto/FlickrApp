class SiteController < ApplicationController
  def index
  end

  def results
    @search = Search.new(params[:search])
    @photos = @search.photos
  end

  # def search

  # end
end
