class CreateEvaluations < ActiveRecord::Migration[5.0]
  def change
    create_table :evaluations do |t|
      t.integer   :user_id,       null: false
      t.integer   :course_id,     null: false

      t.integer   :point_overall,   null: false
      # t.integer   :point_easiness,  null: false
      # t.integer   :point_gpa_satisfaction,  null: false
      # t.integer   :point_clarity,   null: false
      t.text      :body,         null: false

      t.timestamps null: false
    end
  end
end
