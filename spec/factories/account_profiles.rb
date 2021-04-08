FactoryBot.define do
  factory :account_profile do
    first_name { "太郎" }
    last_name { "山田" }
    first_name_kana { "タロウ" }
    last_name_kana { "ヤマダ" }
    gender { "male" }
    phone { "090-1234-5678" }
    postal_code { "107-0051" }
    address { "東京都港区元赤坂1-7-18" }
    date_of_birth { "2019-08-24" }
    biography { "自己PR/紹介" }

    trait :first_name_hanako do
      first_name { "花子" }
    end
  end
end
