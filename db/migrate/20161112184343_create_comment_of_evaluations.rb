class CreateCommentOfEvaluations < ActiveRecord::Migration[5.0]
  def change
    create_table :comment_of_evaluations do |t|
      t.integer :evaluation_id, null: false
      t.integer :user_id, null: false
      t.text :body, null: false

      t.timestamps null: false
    end
  end
end