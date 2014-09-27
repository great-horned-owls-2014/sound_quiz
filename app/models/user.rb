class User < ActiveRecord::Base
  has_many :user_answers

  def percentage_correct_for_current_quiz (quiz_id, user_answers_arr)
    total_attempts_for_this_quiz = 5.0
    total_successful_attempts_for_this_quiz = 0.0
    quiz = Quiz.find(quiz_id)
    quiz_questions = quiz.questions

    quiz_questions.each do | question |
      user_answers_arr.each do | user_answer |
        if question.right_answer.id == user_answer.user_decision.id
          total_successful_attempts_for_this_quiz += 1
        end
      end
    end

    total_successful_attempts_for_this_quiz / total_attempts_for_this_quiz
  end

  def all_time_percentage_correct # returns percentage correct vs all questions ever taken
    total_attempts_ever = self.user_answers.count.to_f

    total_successful_attempts_ever = self.user_answers.joins(:question).where('user_answers.track_id = questions.track_id').count.to_f

    total_successful_attempts_ever / total_attempts_ever
  end



  # def average_of_all_time_percentage_correct_for_quiz (quiz_id)

  #   self.user_answers.joins(:question).where('user_answers.track_id = questions.track_id' && 'questions.quiz_id = ?', quiz_id)

  # end

  # user_answers.joins(:question).where(user_answers.track_id = questions.track_id' && 'questions.quiz_id = ?', quiz_id)

end

#============
# QUESTIONS
#============

# user_answers should have a boolean that says if it's correct or not.
