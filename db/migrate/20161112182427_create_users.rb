class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string      :nickname,  null: false, unique: true
      t.string      :email,     null: false, unique: true
      t.integer     :university_id,   null: false
      t.integer     :major_id,  null: false

      # password
      t.string      :password_digest,  null: false
      t.string      :remember_digest

      t.boolean     :is_boy,        null: false #피지컬한 성별받는 걸로
      t.boolean     :confirmed,     null: false,  default: false #학교메일 인증 확인
      t.boolean     :dropped_out,   null: false,  default: false
      t.datetime    :dropped_out_at
      t.boolean     :allowed,       null: false,  default: false #필수로 써야하는 강평 수를 채운 경우

      t.integer     :point, null: false, default: 0 #강평 및 위키 읽기 구독을 획득하기 위한 점수
      ## Trackable
      t.integer  :sign_in_count,  default: 1, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      t.boolean  :activated,  default: false
      t.string   :activation_digest

      t.datetime :activated_at
      t.datetime :activation_sent_at

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      # t.integer  :mandatory_evaluation_count, null: false, default: 3 #필수로 써야하는 강평 수

      t.timestamps null: false
    end
  end
end
