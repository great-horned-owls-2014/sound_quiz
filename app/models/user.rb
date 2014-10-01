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
      quiz_questions = quiz.questions.order(id: :asc)
      user_answers_arr.sort_by{|x| x.question_id}

      quiz_answers = quiz_questions.map{|x| x.track_id}
      user_choices = user_answers_arr.map{|x| x.track_id}
      pairs = user_choices.zip(quiz_answers)

      i = 1
      total_correct = 0
      question_scores = []

      pairs.each do |pair|
        if  pair[0] == pair[1]
          question_score = (1 * 100000) + ((time_arr[i] - time_arr[i-1]) * 10)
          question_scores << question_score
          total_correct += 1
        end

        i += 1

      end

      question_scores.reduce(:+)



      # scores_per_question = []

      # user_answers_arr.each do | user |

      # puts "=" * 50
      # puts "Here are the times in the times_arr:"
      # puts time_arr
      # puts "=" * 50

      # puts "=" * 50
      # puts "Here are your user's answers:"
      # puts user_answers_arr
      # puts "=" * 50

      # time_elapsed_for_quiz = time_arr.reduce(:+)
      # inverse_time_elapsed = 1.0 / time_elapsed_for_quiz
      # time_bonus = inverse_time_elapsed * 1000

      # score = multiplied_num_correct + time_bonus

    else

      score = 0

    end

    # raw_score = number_correct_for_current_quiz(quiz_id, user_answers_arr) * inverse_time_elapsed

    # meaningful_score = (raw_score * 1000000000 * multiplier).to_i
  end

  def all_time_percentage_correct # returns percentage correct vs all questions ever taken
    total_attempts_ever = self.user_answers.count.to_f
    total_successful_attempts_ever = self.user_answers.joins(:question).where('user_answers.track_id = questions.track_id').count.to_f
    total_successful_attempts_ever / total_attempts_ever
  end

  def number_correct_for_current_quiz (quiz_id, user_answers_arr)
    total_successful_attempts_for_this_quiz = 0
    quiz = Quiz.find(quiz_id)
    quiz_questions = quiz.questions.order(id: :asc)
    user_answers_arr.sort_by{|x| x.question_id}

    answers = quiz_questions.map{|x| x.track_id}
    choices = user_answers_arr.map{|x| x.track_id}
    pairs = choices.zip(answers)
    pairs.each{|pair| total_successful_attempts_for_this_quiz +=1 if  pair[0] == pair[1]  }

    total_successful_attempts_for_this_quiz
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

