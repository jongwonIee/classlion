class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string      :nickname,  null: false, unique: true
      t.string      :email,     null: false, unique: true
      t.integer     :university_id,   null: false

      # password
      t.string      :password_digest,  null: false
      t.string      :remember_digest

      t.boolean     :is_boy,        null: false   #피지컬한 성별받는 걸로
      t.boolean     :confirmed,     null: false,  default: false #학교메일 인증 확인
      t.boolean     :dropped_out,   null: false,  default: false
      t.datetime    :dropped_out_at

      t.integer     :point, null: false, default: 0 #강평 및 위키 읽기 구독을 획득하기 위한 점수

      ## Confirmable
      t.boolean  :activated,  default: false
      t.datetime :activated_at

      t.timestamps null: false
    end
  end
end
