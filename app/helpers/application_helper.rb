module ApplicationHelper

  def create_frontend_quiz(artist, quiz_id)
    quiz = {}
    quiz[:artist] = artist.name
    quiz[:id] = artist.id
    quiz[:itunes_id] = artist.itunes_id

    artist.quizzes.find(quiz_id).questions.each_with_index do |question, index|
      quiz[("question#{(index+1).to_s}").to_sym] = {}
      quiz[("question#{(index+1).to_s}").to_sym][:choices] = []
      quiz[("question#{(index+1).to_s}").to_sym][:choices] << question.right_answer
      question.wrong_choices.each do |choice|
        quiz[("question#{(index+1).to_s}").to_sym][:choices] << choice.track
      end
    end

    return quiz
  end

  def populate_quiz(artist, quiz_id)
    answer_tracks = artist.tracks.first(5)

    while artist.quizzes.find(quiz_id).questions.length < 5
      artist.quizzes.find(quiz_id).questions << Question.create(right_answer: answer_tracks.shift)
    end

    artist.quizzes.find(quiz_id).questions.each do |question|
      choices = artist.tracks.first(10)
      while question.wrong_choices.length < 3
        potential_wrong_answer = choices.pop
        if potential_wrong_answer != question.right_answer
          question.wrong_choices << WrongChoice.create(track: potential_wrong_answer )
        end
      end
    end
  end


end
