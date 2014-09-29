require 'bcrypt'

class User < ActiveRecord::Base
  # validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
  validates_uniqueness_of :email
  validates_presence_of :username

  has_many :user_answers
  has_many :taken_quizzes
  has_secure_password #takes care of password prescence validation

  def quiz_score (quiz_id, user_answers_arr, time_arr)

    difficulty = Quiz.find(quiz_id).difficulty_level

    if difficulty == 1
      multiplier = 1
    elsif difficulty == 2
      multiplier = 1.5
    else
      multiplier = 2.5
    end

    time_elapsed_for_quiz = time_arr.reduce(:+)
    inverse_time_elapsed = 1.0 / time_elapsed_for_quiz
    raw_score = number_correct_for_current_quiz(quiz_id, user_answers_arr) * inverse_time_elapsed

    meaningful_score = (raw_score * 1000000000 * multiplier).to_i
  end

  def all_time_percentage_correct # returns percentage correct vs all questions ever taken
    total_attempts_ever = self.user_answers.count.to_f
    total_successful_attempts_ever = self.user_answers.joins(:question).where('user_answers.track_id = questions.track_id').count.to_f
    total_successful_attempts_ever / total_attempts_ever
  end

  private

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
end

