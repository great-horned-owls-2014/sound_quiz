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

    num_correct = number_correct_for_current_quiz(quiz_id, user_answers_arr)

    if num_correct > 0

      quiz = Quiz.find(quiz_id)
      quiz_questions = quiz.questions
      quiz_answers = quiz_questions.map{|x| x.track_id}

      user_answers_arr.sort_by{|x| x.question_id}
      user_choices = user_answers_arr.map{|x| x.track_id}

      pairs = user_choices.zip(quiz_answers)

      i = 0
      question_scores = []

      pairs.each do |pair|
        if  pair[0] == pair[1]
          question_score = 100000
          time_bonus = (  ( 1 - time_arr[i]  / 30000 ) * 100000)
          total_question_score = question_score + time_bonus
          question_scores << total_question_score
        end
        i += 1
      end
      grand_total_for_quiz = question_scores.reduce(:+)
    else
      grand_total_for_quiz = 0
    end
    grand_total_for_quiz
  end

  def all_time_percentage_correct # returns percentage correct vs all questions ever taken
    total_attempts_ever = self.user_answers.count.to_f
    total_successful_attempts_ever = self.user_answers.joins(:question).where('user_answers.track_id = questions.track_id').count.to_f
    total_successful_attempts_ever / total_attempts_ever
  end

  def number_correct_for_current_quiz (quiz_id, user_answers_arr)
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

