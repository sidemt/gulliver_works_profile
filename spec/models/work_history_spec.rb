require 'rails_helper'

RSpec.describe WorkHistory, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  let!(:account) { create(:account)}

  describe 'バリデーション' do
    context '在職中の場合' do
      let(:work_history) { build(:work_history, account: account) }
      context '終了日が未入力' do
        it '有効であること' do
          expect(work_history).to be_valid
        end
      end
    end

    context '離職中の場合' do
      context '終了日が未入力' do
        let(:work_history) { build(:work_history, :is_employed_false, account: account) }
        it '無効であること' do
          expect(work_history).not_to be_valid
        end
      end

      context '終了日が入力済' do
        let(:work_history) { build(:work_history, :is_employed_false, :has_until_date, account: account) }
        it '有効であること' do
          expect(work_history).to be_valid
        end
      end
    end
  end
end
