class ArtistsController < ApplicationController
  autocomplete :artist, :name

  def index
    @artist = Artist.new
  end

end
