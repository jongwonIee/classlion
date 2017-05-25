class CreateLectures < ActiveRecord::Migration[5.1]
  def change
    create_table :lectures do |t|
      t.string      :name,          null: false
      t.integer     :university_id, null: false
      t.integer     :unit #이수학점

      t.timestamps null: false
    end
  end
end
