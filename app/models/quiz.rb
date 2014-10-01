class Quiz < ActiveRecord::Base
  belongs_to :artist
  has_many :questions

  def self.create_quiz(artist, difficulty)
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
end
