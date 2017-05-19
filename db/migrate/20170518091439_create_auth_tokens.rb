class CreateAuthTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :auth_tokens do |t|
      t.integer   :user_id,   null: false
      t.integer   :auth_type, null: false
      t.string    :token,     null: false

      t.timestamps
    end
  end
end
