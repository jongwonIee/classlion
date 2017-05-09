class CreateUniversities < ActiveRecord::Migration[5.1]
  def change
    create_table :universities do |t|
      t.string      :local_name,            null: false #한국이면 한국어, 호주면 영어
      t.string      :english_name,    null: false #영어명
      t.string      :email_domain,    null: false #이메일 도메인
      t.boolean     :need_activation, null: false #이메일 인증이 필요한 학교를 대상으로 함
      t.integer     :user_count,      default: 0
      t.integer     :evaluation_count,default: 0

      t.timestamps null: false
    end
  end
end
