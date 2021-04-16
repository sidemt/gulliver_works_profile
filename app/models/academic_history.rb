class AcademicHistory < ApplicationRecord
  belongs_to :account

  self.inheritance_column = :_type_disabled # type カラムをSTIに使用しないようにする
  enum type: { graduate_school:   0,  # 大学院
               university:        1,  # 大学
               vocational_school: 2,  # 専門学校
               junior_college:    3,  # 短期大学
               high_school:       4 } # 高校
  attribute :type, :integer, default: 0

  validates :name,
            :since_date,
            :until_date,
            :type, presence: true

  # "YYYY-MM" 形式のStringでの入力を、月初の日付のDateに変換して保存できるようにする
  def since_date=(val)
    date = parse_year_date(val)
    super(date)
  end

  def until_date=(val)
    date = parse_year_date(val)
    super(date)
  end

  private
    # "YYYY-MM" 形式のStringをDateに変換する
    def parse_year_date(str)
      Date.strptime(str, "%Y-%m")
    end
end
