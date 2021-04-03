FactoryBot.define do
  factory :account_profile do
    first_name { "太郎" }
    last_name { "山田" }
    first_name_kana { "タロウ" }
    last_name_kana { "ヤマダ" }
    gender { "MALE" }
    phone { "090-1234-5678" }
    postal_code { "107-0051" }
    address { "東京都港区元赤坂1-7-18" }
    date_of_birth { "2019-08-24" }
    biography { "自己PR/紹介" }
  end

  factory :account_profile_b, class: AccountProfile do
    first_name { "花子" }
    last_name { "田中" }
    first_name_kana { "ハナコ" }
    last_name_kana { "タナカ" }
    gender { "FEMALE" }
    phone { "03-0000-0000" }
    postal_code { "111-1111" }
    address { "東京都千代田区千代田1-7-18" }
    date_of_birth { "2000-01-01" }
    biography { "自己PR/紹介2" }
  end
end
