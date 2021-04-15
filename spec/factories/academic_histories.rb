FactoryBot.define do
  factory :academic_history do
    name { "明治大学" }
    faculty { "情報コミュニケーション学部" }
    since_date { "2008-04" }
    until_date { "2012-03" }
    type { "university" }
  end
end
