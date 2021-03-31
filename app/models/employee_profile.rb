class EmployeeProfile < Profile
  has_one :employee, dependent: :destroy
end
