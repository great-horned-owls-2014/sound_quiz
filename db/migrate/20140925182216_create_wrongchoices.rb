class CreateWrongchoices < ActiveRecord::Migration
  def change
    create_table :wrongchoices do |t|
      t.references :track
      t.references :question

      t.timestamps
    end
  end
end
