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
    # puts
    # puts "=" * 50
    # puts params[:answerArray]
    # puts "=" * 50
    # puts

    ## Have this route update user_answers.user_decision with the choices
    ## Have this route also write the resulting score to a scores table. A user has many scores. A quiz has many scores. Scores table should have user_id, quiz_id, and score (integer).
    session[:user_id] = 1
    user = User.find(session[:user_id])
    params[:returnVals].values.each do |x|
      user.user_answers << UserAnswer.create(
        question_id: x[:question].to_i,
        track_id: x[:track_id].to_i,
        response_time: x[:response_time].to_f
      )
    end

    binding.pry

  end

end
