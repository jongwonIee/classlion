class CreateLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :likes do |t|
      t.integer :user_id,       null:false
      t.integer :course_id,     null:false
      t.integer :evaluation_id
      t.boolean :is_like,       null:false

      t.timestamps
    end
  end
end
