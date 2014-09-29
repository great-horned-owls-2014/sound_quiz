class ArtistsController < ApplicationController
  autocomplete :artist, :name

  def index
    @artist = Artist.new
    @artists = Artist.all
  end

  def show
    artist_id = params[:id]
  	@artist = Artist.find(artist_id)

    avg_scores = TakenQuiz.where(artist_id: artist_id).joins(:user).group('users.id').group('users.username').average(:score)
    @sorted_avg_scores = avg_scores.sort_by {|user_info, avg_score| avg_score}.reverse
  end
end
