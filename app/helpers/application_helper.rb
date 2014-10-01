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
end
