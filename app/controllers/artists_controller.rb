class ArtistsController < ApplicationController
  autocomplete :artist, :name

  def index
    @artist = Artist.new
  end

  def show
  	@artist = Artist.find(params[:id])
  	@user_taken = Hash.new(0)
    @artist.taken_quizzes.each { |takenquiz| @user_taken[takenquiz.user.id] += 1}
  end

end
