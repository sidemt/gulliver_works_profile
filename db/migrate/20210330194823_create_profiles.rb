class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles, id: :uuid, comment: 'プロフィール' do |t|
      t.string :type, comment: 'STIを使用するためのtype'
      t.references :account, index: true, foreign_key: true, type: :uuid
      t.references :employee, index: true, foreign_key: true, type: :uuid
      t.string :first_name, null: false, comment: '名前'
      t.string :last_name, null: false, comment: '苗字'
      t.string :first_name_kana, null: false, comment: '名前(フリガナ)'
      t.string :last_name_kana, null: false, comment: '苗字(フリガナ)'
      t.integer :gender, null: false, default: 2, comment: '性別'
      t.string :phone, null: false, comment: '電話番号'
      t.string :postal_code, comment: '郵便番号'
      t.string :address, comment: '住所'
      t.date :date_of_birth, null: false, comment: '生年月日'
      t.string :biography, comment: '自己紹介'

      t.timestamps
    end
  end
end
