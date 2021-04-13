class CreateWorkHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :work_histories, id: :uuid, comment: '職歴' do |t|
      t.references :account, foreign_key: true, type: :uuid
      t.boolean :is_employed, null: false, default: true, comment: '在職中/離職中'
      t.references :occupation, foreign_key: true, type: :uuid
      t.references :industry, foreign_key: true, type: :uuid
      t.string :position, null: false, comment: '役職'
      t.integer :annual_income, null: false, comment: '年収'
      t.integer :management_experience, null: false, comment: '経験年数'
      t.string :job_summary, comment: '業務内容'
      t.date :since_date, null: false, comment: '開始日'
      t.date :until_date, comment: '終了日'
      t.string :name, null: false, comment: '社名'

      t.timestamps
    end
  end
end
