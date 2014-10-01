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
    raw_score = number_correct_for_current_quiz(user_answers_arr) * inverse_time_elapsed

    meaningful_score = (raw_score * 1000000000 * multiplier).to_i
  end

  def all_time_percentage_correct # returns percentage correct vs all questions ever taken
    total_attempts_ever = self.user_answers.count.to_f
    total_successful_attempts_ever = self.user_answers.joins(:question).where('user_answers.track_id = questions.track_id').count.to_f
    total_successful_attempts_ever / total_attempts_ever
  end

  def number_correct_for_current_quiz ( user_answers_arr)
    total_correct = 0
    user_answers_arr.each do |ans|
      total_correct += 1 if ans.user_decision == ans.question.right_answer
    end
    total_correct
  end

  def artist_score(artist)
    scores_array = []
    self.taken_quizzes.each do |takenquiz|
      if takenquiz.quiz.artist == artist
        scores_array << takenquiz.score
      end
    end

    average = scores_array.reduce(:+).to_f / scores_array.size
  end

end

