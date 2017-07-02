class CreateEvaluations < ActiveRecord::Migration[5.1]
  def change
    create_table :evaluations do |t|
      t.integer   :user_id,       null: false
      t.integer   :course_id,     null: false
      t.integer   :like_id,       null: false
      t.text      :body,          null: false

      t.timestamps null: false
    end
    add_index :evaluations, :like_id, :unique => true
  end
end
