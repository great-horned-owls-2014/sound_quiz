class CreateUseranswers < ActiveRecord::Migration
  def change
    create_table :useranswers do |t|
      t.belongs_to :user
      t.references :question
      t.references :track
      t.float :response_time

      t.timestamps
    end
  end
end
