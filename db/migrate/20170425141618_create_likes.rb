class CreateLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :likes do |t|
      t.integer :user_id, null:false
      t.string  :state, default: "unknown"
      t.integer :is_like_total
      t.integer :evaluation_id

      t.timestamps
    end
  end
end
