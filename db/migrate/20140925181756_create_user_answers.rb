class CreateUserAnswers < ActiveRecord::Migration
  def change
    create_table :user_answers do |t|
      t.belongs_to :user
      t.references :question
      t.references :track
      t.float :response_time

      t.timestamps
    end
  end
end
