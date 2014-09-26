class QuizController < ApplicationController
  def create
    new_artist = Artist.create(name: params[:name], itunes_id: params[:id])
    new_artist.quizzes << Quiz.create(difficulty_level: 1)
    for  i in 0..(params[:list].length - 1 ) do
      new_track = Track.create(
        preview_url: params[:list][i.to_s]["previewUrl"],
        art_url: params[:list][i.to_s]["artworkUrl100"],
        name: params[:list][i.to_s]["trackName"]  )
      new_artist.tracks << new_track

      if new_artist.quizzes.last.questions.length < 5
        new_artist.quizzes.last.questions << Question.create(right_answer: new_track)
      end
    end

    new_artist.quizzes.last.questions.each do |question|
      choices = new_artist.tracks.first(10)
      while question.wrong_choices.length < 3
        potential_wrong_answer = choices.pop
        if potential_wrong_answer != question.right_answer
          question.wrong_choices << WrongChoice.create(track: potential_wrong_answer )
        end
      end
    end

    quiz = {}
    quiz[:artist] = new_artist.name
    quiz[:id] = new_artist.id
    quiz[:itunes_id] = new_artist.itunes_id

    new_artist.quizzes.last.questions.each_with_index do |question, index|
      quiz[("question#{(index+1).to_s}").to_sym] = {}
      quiz[("question#{(index+1).to_s}").to_sym][:choices] = []
      quiz[("question#{(index+1).to_s}").to_sym][:choices] << question.right_answer
      question.wrong_choices.each do |choice|
        quiz[("question#{(index+1).to_s}").to_sym][:choices] << choice.track
      end
    end

    render :json => quiz
  end
end
