class User < ActiveRecord::Base
  has_many :user_answers

  def all_time_percentage_correct # gives ration/percentage of correct vs all questions ever taken

    total_attempts_ever = self.user_answers.count.to_f

    total_successful_attempts_ever = self.user_answers.joins(:question).where('user_answers.track_id = questions.track_id').count.to_f

    total_successful_attempts_ever / total_attempts_ever

  end

  # def percentage_correct_for_current_quiz



  # end


  # def average_of_all_time_percentage_correct_for_quiz (quiz_id)

  #   self.user_answers.joins(:question).where('user_answers.track_id = questions.track_id' && 'questions.quiz_id = ?', quiz_id)

  # end




  # user_answers.joins(:question).where(user_answers.track_id = questions.track_id' && 'questions.quiz_id = ?', quiz_id)

end
