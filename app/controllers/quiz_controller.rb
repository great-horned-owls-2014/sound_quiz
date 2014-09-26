class QuizController < ApplicationController
  def create
    new_artist = Artist.create(name: params[:name], itunes_id: params[:id])
    new_artist.quizzes << Quiz.create(difficulty_level: 1)
    for  i in 0..(params[:list].length - 1 ) do
      new_track = Track.create(
        preview_url: params[:list][i.to_s]["previewUrl"],
        art_url: params[:list][i.to_s]["artworkUrl100"],
        name: params[:list][i.to_s]["trackName"]  )
      new_artist.tracks << new_track
    end

    populate_quiz(new_artist, new_artist.quizzes.last.id)

    render :json => create_frontend_quiz(new_artist, new_artist.quizzes.last.id)
  end
end
