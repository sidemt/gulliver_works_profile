class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles, id: :uuid do |t|
      t.string :type
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :first_name_kana, null: false
      t.string :last_name_kana, null: false
      t.integer :gender, null: false
      t.string :phone, null: false
      t.string :postal_code, null: false
      t.string :address, null: false
      t.date :date_of_birth, null: false
      t.string :biography, null: false

      t.timestamps
    end
  end
end
