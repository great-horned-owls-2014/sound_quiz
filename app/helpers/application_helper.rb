module ApplicationHelper

  def create_frontend_quiz(artist, quiz_id)
    quiz = {}
    quiz[:artist] = artist.name
    quiz[:id] = artist.id
    quiz[:itunes_id] = artist.itunes_id

    artist.quizzes.find(quiz_id).questions.each_with_index do |question, array_index|
      human_index = (array_index + 1).to_s
      quiz[("question#{human_index}").to_sym] = {}
      quiz[("question#{human_index}").to_sym][:db_id] = question.id
      quiz[("question#{human_index}").to_sym][:choices] = []
      quiz[("question#{human_index}").to_sym][:choices] << question.right_answer
      question.wrong_choices.each do |choice|
        quiz[("question#{human_index}").to_sym][:choices] << choice.track
      end
      quiz[("question#{human_index}").to_sym][:choices].shuffle
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
