module ApplicationHelper

  QUIZKEY = {
    0 => {difficulty: 0, source: 5, choices:  10},
    1 => {difficulty: 1, source: 5, choices:  15 },
    2 => {difficulty: 2, source: 10, choices: 20 },
    3 => {difficulty: 3, source: 20, choices: 20 }
  }

  def signed_in?
    session[:user_id] ? true : false
  end

  def artist_created?(artist_itunes_id)
    Artist.find_by(itunes_id: artist_itunes_id) ? true : false
  end

  def initialize_new_artist_tracks(artist, songlist)
    new_artist_tracks = []
    songlist.length.times.map do |i|
      new_track = Track.new(track_attribs_from_params(songlist[i.to_s]))
      if new_track.save != false
        new_artist_tracks << new_track
      end
    end

    artist.tracks = new_artist_tracks
    artist.save!
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
    question_hash = {}
    question_hash[:db_id] = question.id
    question_hash[:player_url] = question.right_answer.preview_url
    question_hash[:choices] = [ question.right_answer ] + question.wrong_choices.map(&:track)
    question_hash[:choices] = question_hash[:choices].shuffle
    question_hash
  end


  def create_quiz(artist, difficulty)
    new_quiz = Quiz.new(difficulty_level: difficulty)
    if difficulty >= 3
      quiz_key_difficulty = 3
    else
      quiz_key_difficulty = difficulty
    end
    answer_tracks = artist.tracks.first(QUIZKEY[quiz_key_difficulty][:source])
    answer_tracks.shuffle!

    while new_quiz.questions.length < 5
      new_quiz.questions << Question.new(right_answer: answer_tracks.shift)
    end

    new_quiz.questions.each do |question|
      choices = artist.tracks.first(QUIZKEY[quiz_key_difficulty][:choices])
      choices.shuffle!
      while question.wrong_choices.length < 3
        potential_wrong_answer = choices.pop
        if potential_wrong_answer != question.right_answer
          question.wrong_choices << WrongChoice.new(track: potential_wrong_answer )
        end
      end
    end

    if difficulty > 0
      artist.quizzes << new_quiz
      artist.save!
    end

    new_quiz.save!
    new_quiz
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

end
