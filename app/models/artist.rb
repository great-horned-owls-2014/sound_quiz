class Artist < ActiveRecord::Base
  has_many :tracks
  has_many :quizzes
  has_many :taken_quizzes

  validates :tracks, :length => { :minimum => 25 }


  def add_track_if_not_present (track_params)
    if ! Track.find_by_name(track_params[:name])
      self.tracks << Track.create(track_params)
      self.save
    end
  end
end
