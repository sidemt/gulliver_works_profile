require 'rails_helper'

RSpec.describe AcademicHistory, type: :model do
  let!(:account) { create(:account)}

  describe '"YYYY-MM"の形式で入力し、月初の日付に変換して保存する' do
    let(:academic_history) { create(:academic_history, account: account) }

    it 'since_dateが正しく入力されること' do
      expect(academic_history.since_date).to eq "2008-04-01".to_date
    end

    it 'until_dateが正しく入力されること' do
      expect(academic_history.until_date).to eq "2012-03-01".to_date
    end
  end
end
