class CreateWrongChoices < ActiveRecord::Migration
  def change
    create_table :wrong_choices do |t|
      t.references :track
      t.references :question

      t.timestamps
    end
  end
end
