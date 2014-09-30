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

  def first_quiz
    @artist = Artist.find(params[:id])
    @quiz = @artist.quizzes.first
    # @quiz here might be nil b/c if an anonymous user searches an artist not in the db, our app will populate our db with the artist, its tracks, but not with a quiz. So, even if the artist exists, it doesn't mean it has any quizzes.
    # If a signed_in user searches an artist not in the db, quizzes will be generated and thus, #quizzes is NOT nil.
    render :json => create_frontend_quiz(@artist, @quiz.id)
  end
end
