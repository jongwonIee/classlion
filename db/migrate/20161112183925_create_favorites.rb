class CreateFavorites < ActiveRecord::Migration[5.0]
  def change
    create_table :favorites do |t|
      
      t.integer   :user_id,   null: false
      t.integer   :course_id, null: false
      t.boolean   :is_like, defaule: false

      t.timestamps null: false
    end
  end
end
