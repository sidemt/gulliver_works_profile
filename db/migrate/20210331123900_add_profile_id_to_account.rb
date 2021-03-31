class AddProfileIdToAccount < ActiveRecord::Migration[6.0]
  def change
    add_reference :accounts, :account_profile, type: :uuid, foreign_key: { to_table: :profiles }
  end
end
