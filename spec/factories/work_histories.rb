FactoryBot.define do
  factory :work_history do
    is_employed { false }
    occupation { nil }
    industry { nil }
    position { "MyString" }
    annual_income { 1 }
    management_experience { 1 }
    job_summary { "MyString" }
    since_date { "2021-04-08" }
    until_date { "2021-04-08" }
    name { "MyString" }
  end
end
