class CreateMajors < ActiveRecord::Migration[5.0]
  def change
    create_table :majors do |t|
      t.string :name, null: false #전공명말고 또 들어갈만 한게 있을까?
      t.integer :university_id, null: false #어떤 학교의 전공인지
      t.timestamps null: false
    end
  end
end
