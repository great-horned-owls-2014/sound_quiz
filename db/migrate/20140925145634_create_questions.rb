class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :api_content
      t.references :track

      t.timestamps
    end
  end
end
