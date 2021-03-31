class AccountProfile < Profile
  has_one :account, dependent: :destroy
end
