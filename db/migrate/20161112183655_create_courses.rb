class CreateCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
      t.integer     :professor_id,  null: false
      t.integer     :lecture_id,    null: false
      t.integer     :university_id, null: false
      t.integer     :evaluation_count, default: 0 , null: false

      t.integer   :point_overall_sum, default: 0 , null: false
      t.integer   :point_easiness_sum, default: 0 , null: false
      t.integer   :point_gpa_satisfaction_sum, default: 0 , null: false
      t.integer   :point_clarity_sum, default: 0 , null: false

      t.boolean     :is_major, default: true, null: false
      t.timestamps null: false
    end
  end
end
