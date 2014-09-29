class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :track #aliased as right answer
      t.belongs_to :quiz

      t.timestamps
    end
  end
end
