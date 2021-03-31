class AddProfileIdToEmployee < ActiveRecord::Migration[6.0]
  def change
    add_reference :employees, :employee_profile, type: :uuid, foreign_key: { to_table: :profiles }
  end
end
