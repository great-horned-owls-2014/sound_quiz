class QuizController < ApplicationController



  def create
    # artist & tracks, knows nothing of quiz
    artist_itunes_id = params[:id]
    if artist_created?(artist_itunes_id)
      artist = Artist.find_by(itunes_id: artist_itunes_id)
    else
      artist = Artist.new(artist_attribs_from_params(params))
      initialize_new_artist_tracks(artist, params[:list])
    end

    if signed_in?
      user = User.find(session[:user_id])

      if artist_created?(artist_itunes_id)

        if artist.quizzes.length > 0
          user_quiz_count_of_artist = user.taken_quizzes.where(artist: artist).count
          artist_quiz_count = artist.quizzes.count

          if user_quiz_count_of_artist >= artist_quiz_count
            difficulty = artist_quiz_count + 1
            quiz = create_quiz(artist, difficulty)
            artist.quizzes << quiz
          else
            quiz = artist.quizzes.find_by(difficulty_level: user_quiz_count_of_artist + 1)
          end

        else
          quiz = create_quiz(artist, 1)
          artist.quizzes << quiz
        end

      end

    else
      quiz = create_quiz(artist, 0)
    end

    render :json => create_frontend_quiz(artist, quiz.id)
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
    if signed_in?
      user = User.find(session[:user_id])
      quiz_id = Question.find(params[:returnVals]['0'][:question].to_i).quiz_id
      answers = []
      times = []

      params[:returnVals].values.each do |x|

        new_answer = UserAnswer.create(
          question_id: x[:question].to_i,
          track_id: x[:track_id].to_i,
          response_time: x[:response_time].to_f
        )

        user.user_answers << new_answer
        answers << new_answer

        times << x[:response_time].to_f
      end
    end
#NEED TO ADD ARTIST ID IN HERE
    new_record = TakenQuiz.create(quiz_id: quiz_id, time: times.reduce(:+), score: user.quiz_score(quiz_id, answers, times), artist_id: Quiz.find(quiz_id).artist.id)
    user.taken_quizzes << new_record

    render :json => new_record.score

  end

end
