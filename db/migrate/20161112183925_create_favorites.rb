class CreateFavorites < ActiveRecord::Migration[5.0]
  def change
    create_table :favorites do |t|
      #강의 즐겨찾기
      t.integer   :user_id,   null: false
      t.integer   :course_id, null: false

      t.timestamps null: false
    end
  end
end
