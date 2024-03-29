class CreateWikis < ActiveRecord::Migration[5.1]
  def change
    create_table :wikis do |t|

      t.integer   :user_id,       null: false
      t.integer   :revision,      null: false
      t.integer   :course_id,     null: false
      t.integer   :diff,          null: false
      t.text      :body,          null: false
      t.integer   :rollback,      null: false,  default: -1
      t.string    :comment

      t.timestamps
    end
    add_index :wikis, :revision
    add_index :wikis, [:course_id, :revision], :unique => true
  end
end
