class QuizController < ApplicationController

  def create
    # artist & tracks, knows nothing of quiz
    new_artist = Artist.new artist_attribs_from_params params

    new_artist_tracks = []
    params[:list].length.times.map do |i|
      new_track = Track.new track_attribs_from_params params[:list][i.to_s]
      if new_track.save != false
        new_artist_tracks << new_track
      end
    end

    new_artist.tracks = new_artist_tracks
    new_artist.save!

    quiz = create_first_quiz_for(new_artist)
    quiz.save!

    render :json => create_frontend_quiz(new_artist, new_artist.quizzes.last.id)
  end

  def artist_attribs_from_params params
    { name: params[:name], itunes_id: params[:id] }
  end

  def track_attribs_from_params track_from_params
    {
      preview_url: track_from_params["previewUrl"],
      art_url: track_from_params["artworkUrl100"],
      name: track_from_params["trackName"]
    }
  end

  def stats

  end

end
