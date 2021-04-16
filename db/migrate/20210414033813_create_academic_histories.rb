class CreateAcademicHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :academic_histories, id: :uuid, comment: '学歴' do |t|
      t.references :account, foreign_key: true, type: :uuid
      t.string :name, null: false, comment: '学校名'
      t.string :faculty, comment: '学部'
      t.date :since_date, null: false, comment: '入学日'
      t.date :until_date, null: false, comment: '卒業日'
      t.integer :type, null: false, default: 0, comment: '学校種別'

      t.timestamps
    end
  end
end
