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
end
