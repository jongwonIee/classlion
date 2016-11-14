class CreateCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
      t.integer     :professor_id,  null: false
      t.integer     :lecture_id,    null: false
      t.integer     :university_id, null: false
      t.integer :evaluation_count, default: 0
      t.integer :point_overall, default: 0 #강의에 대한 전체적인 평가

      # t.integer :point_gpa_satisfaction, default: 0
      # t.integer :point_easiness, default: 0
      # t.integer :point_clarity, default: 0

      t.timestamps null: false
    end
  end
end
