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
      name: track_from_params["trackName"],
      itunes_track_id: track_from_params["trackId"]
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

    quiz_artist_id = Quiz.find(quiz_id).artist.id
    new_record = TakenQuiz.create(quiz_id: quiz_id, time: times.reduce(:+), score: user.quiz_score(quiz_id, answers, times), artist_id: quiz_artist_id)

    user.taken_quizzes << new_record

    itunes_ids = []

    Quiz.find(quiz_id).questions.each do |question|
      itunes_ids << question.right_answer.itunes_track_id
    end    

    @quiz_stats = {
      artist_id: quiz_artist_id,
      score: new_record.score,
      num_of_correct: user.number_correct_for_current_quiz(quiz_id, answers),
      time: times.reduce(:+),
      itunes_track_ids: itunes_ids
    }

    render "stats", locals: {quiz_stats: @quiz_stats}

  end

end
