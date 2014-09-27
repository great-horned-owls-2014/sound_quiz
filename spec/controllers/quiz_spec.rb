require 'rails_helper'

describe QuizController do
  describe "Posting to create" do
    it "returns a json object" do
      post :create, list:[ { 0 => { previewUrl: "http://www.test.com/test",
                   artworkUrl100: "http://www.test.com/art100.jpg",
                   trackName: "Good song that you like" }}]
      puts params
      expect(response).to have_http_status(:created)
    end



  end


end
