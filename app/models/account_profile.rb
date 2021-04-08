class AccountProfile < Profile
  belongs_to :account, optional: true
end
