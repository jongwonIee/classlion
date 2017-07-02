class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.integer     :professor_id,  null: false
      t.integer     :lecture_id,    null: false
      t.integer     :university_id, null: false
      t.boolean     :is_major, default: true, null: false
      t.timestamps null: false
    end
  end
end
