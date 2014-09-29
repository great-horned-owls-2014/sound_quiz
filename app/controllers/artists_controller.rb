class ArtistsController < ApplicationController
  autocomplete :artist, :name

  def index
    @artist = Artist.new
    @artists = Artist.all
  end

  def show
  	@artist = Artist.find(params[:id])
  	@user_taken = Hash.new(0)
    @artist.taken_quizzes.each do |takenquiz|
      @user_taken[takenquiz.user.id] += 1
    end

    @user_score = TakenQuiz.where(artist_id: 1).joins(:user).group('users.username').average(:score)

  end

end
