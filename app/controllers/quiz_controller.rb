class QuizController < ApplicationController

  def initialize_new_artist_tracks(artist, songlist)
    songlist.each do |key, value|
      track_params = track_attribs_from_itunes_hash(value)
      artist.add_track_if_not_present(track_params)
    end
  end

  def create_frontend_quiz(artist, quiz_id)
    quiz = {}
    quiz[:artist] = artist.name
    quiz[:id] = artist.id
    quiz[:itunes_id] = artist.itunes_id

    Quiz.find(quiz_id).questions.each_with_index do |question, array_index|
      human_index = (array_index + 1).to_s
      question_key = ("question_#{human_index}").to_sym
      quiz[question_key] = make_question_hash question
    end

    quiz
  end

  def make_question_hash question
    question_hash = {
      db_id: question.id,
      player_url: question.right_answer.preview_url,
      choices: ( [ question.right_answer ] + question.wrong_choices.map(&:track) ).shuffle
    }
  end

  def create
    # artist & tracks, knows nothing of quiz
    artist_itunes_id = params[:id]
    artist = Artist.find_by(itunes_id: artist_itunes_id)

    if !artist
      artist = Artist.new(artist_attribs_from_params(params))
      initialize_new_artist_tracks(artist, params[:list])
    end

    if current_user
      user = current_user

      if artist

        if artist.quizzes.length > 0
          user_quiz_count_of_artist = user.taken_quizzes.where(artist: artist).count
          artist_quiz_count = artist.quizzes.count

          if user_quiz_count_of_artist >= artist_quiz_count
            difficulty = artist_quiz_count + 1
            quiz = Quiz.create_quiz(artist, difficulty)
            artist.quizzes << quiz
          else
            quiz = artist.quizzes.find_by(difficulty_level: user_quiz_count_of_artist + 1)
          end

        else
          quiz = Quiz.create_quiz(artist, 1)
          artist.quizzes << quiz
        end

      end

    else
      quiz = Quiz.create_quiz(artist, 0)
    end

    render :json => create_frontend_quiz(artist, quiz.id)
  end

  def artist_attribs_from_params params
    { name: params[:name], itunes_id: params[:id] }
  end

  def track_attribs_from_itunes_hash itunes_hash
    {
      preview_url: itunes_hash["previewUrl"],
      art_url: itunes_hash["artworkUrl100"],
      name: itunes_hash["trackName"],
      itunes_track_id: itunes_hash["trackId"]
    }
  end

  def stats
    itunes_ids = []

    if current_user
      user = current_user
      # quiz_id is set to questions.quiz.id
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

      quiz_artist_id = Quiz.find(quiz_id).artist.id
      @artist = Artist.find(quiz_artist_id)
      new_record = TakenQuiz.create(quiz_id: quiz_id, time: times.reduce(:+), score: user.quiz_score(quiz_id, answers, times), artist_id: quiz_artist_id)
      user.taken_quizzes << new_record

      Quiz.find(quiz_id).questions.each do |question|
        itunes_ids << question.right_answer.itunes_track_id
      end
      @quiz_stats = {
        artist_id: quiz_artist_id,
        score: new_record.score,
        num_of_correct: user.number_correct_for_current_quiz(answers),
        time: times.reduce(:+),
        itunes_track_ids: itunes_ids
      }
    else
      answers = []
      times = []
      quiz_id = Question.find(params[:returnVals]["0"]["question"].to_i).quiz.id
      quiz_artist_id = Artist.find_by(itunes_id: params[:artistId])
      dummy_user = User.new(username: 'dummy', email: 'dummy@dummy')

      params[:returnVals].values.each do |x|
        new_answer = UserAnswer.new(
          question_id: x[:question].to_i,
          track_id: x[:track_id].to_i,
          response_time: x[:response_time].to_f
        )

        dummy_user.user_answers << new_answer
        answers << new_answer

        times << x[:response_time].to_f
      end

      new_record = TakenQuiz.new(time: times.reduce(:+), score: dummy_user.quiz_score(quiz_id, answers, times))

      dummy_user.taken_quizzes << new_record

      Quiz.find(quiz_id).questions.each do |question|
        itunes_ids << question.right_answer.itunes_track_id
      end

      @quiz_stats = {
        artist_id: quiz_artist_id,
        score: new_record.score,
        num_of_correct: dummy_user.number_correct_for_current_quiz(answers),
        time: times.reduce(:+),
        itunes_track_ids: itunes_ids.shuffle
      }
    end
    render partial: "/stats"
  end
end
