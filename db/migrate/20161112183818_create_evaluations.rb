class CreateEvaluations < ActiveRecord::Migration[5.0]
  def change
    create_table :evaluations do |t|
      t.integer   :user_id,       null: false
      t.integer   :course_id,     null: false

      t.integer   :point_overall, default: 0 , null: false
      t.integer   :point_easiness, default: 0 , null: false
      t.integer   :point_gpa_satisfaction, default: 0 , null: false
      t.integer   :point_clarity, default: 0 , null: false

      t.text      :body,         null: false

      t.timestamps null: false
    end
  end
end