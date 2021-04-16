# frozen_string_literal: true
# Ability
class Ability
  include CanCan::Ability

  def initialize(account)
    account ||= Account.new

    can :read, Account
    can :manage, Account, id: account.id
    can :read, AccountProfile
    can :manage, AccountProfile, account: { id: account.id }
    can :read, WorkHistory
    can :manage, WorkHistory, account: { id: account.id }
    can :read, AcademicHistory
    can :manage, AcademicHistory, account: { id: account.id }
    can :read, OccupationMainCategory
    can :read, OccupationSubCategory
    can :read, Occupation
    can :read, IndustryCategory
    can :read, Industry
    can :read, Prefecture
    can :read, EmploymentStatus
  end
end
