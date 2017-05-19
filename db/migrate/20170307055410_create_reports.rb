class CreateReports < ActiveRecord::Migration[5.1]
  def change
    create_table :reports do |t|
      t.integer :user_id,         null: false
      t.integer :evaluation_id,   null: false
      t.text    :body

      t.timestamps
    end
  end
end
