class CreateProfessors < ActiveRecord::Migration[5.0]
  def change
    create_table :professors do |t|
      t.integer   :university_id, null: false
      t.string    :name,          null: false

      #프로필 사진
      t.string    :photo_url #사진 경로
      t.integer   :uploader_id #업로더한 사람 id

      t.timestamps null: false
    end
  end
end
