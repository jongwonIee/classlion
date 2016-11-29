class CreateWikis < ActiveRecord::Migration[5.0]
  def change
    create_table :wikis do |t|

      t.integer   :user_id,       null: false
      t.integer   :course_id,     null: false
      t.text      :body,         null: false

      t.timestamps
    end
  end
end
