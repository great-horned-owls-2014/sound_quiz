class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :name
      t.string :preview_url
      t.string :art_url
      t.belongs_to :artist

      t.timestamps
    end
  end
end
