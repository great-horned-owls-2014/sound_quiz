class QuizController < ApplicationController
  def create
    for  i in 0..(params[:list].length - 1 ) do
      puts params[:id]
      puts params[:name]
      puts params[:list][i.to_s]["trackName"]
      puts params[:list][i.to_s]["previewUrl"]
      puts params[:list][i.to_s]["artworkUrl100"]
    end
  end
end
