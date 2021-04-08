class EmployeeProfile < Profile
  belongs_to :employee, optional: true
end
