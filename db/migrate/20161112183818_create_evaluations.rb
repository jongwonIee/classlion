class CreateEvaluations < ActiveRecord::Migration[5.0]
  def change
    create_table :evaluations do |t|
      t.integer   :user_id,       null: false
      t.integer   :course_id,     null: false
      t.text      :body,         null: false
      t.integer   :like_id

      t.timestamps null: false
    end
  end
end