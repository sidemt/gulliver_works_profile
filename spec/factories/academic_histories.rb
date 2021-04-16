FactoryBot.define do
  factory :academic_history do
    sequence(:name) { |n| "学校名_#{n}" }
    faculty { "情報コミュニケーション学部" }
    since_date { "2008-04" }
    until_date { "2012-03" }
    type { "university" }

    trait :type_high_school do
      type { "high_school" }
    end
  end
end
