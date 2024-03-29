class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|

      t.integer :evaluation_id, null: false
      t.integer :user_id,       null: false
      t.text    :body,          null: false

      t.timestamps null: false
    end
  end
end
