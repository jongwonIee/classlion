class CreateLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :likes do |t|
      t.integer :user_id, null:false
      t.integer :course_id, null: false
      t.string  :state, default: "unknown"

      t.timestamps
    end
  end
end
