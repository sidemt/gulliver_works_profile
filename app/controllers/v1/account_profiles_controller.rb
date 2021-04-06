# frozen_string_literal: true

module V1
  class AccountProfilesController < ApplicationController
    before_action :load_and_authorize_account_profile, only: %i[show update]

    def show
      render json: @account_profile
    end

    def create
      account = Account.find(params[:account_id])
      @account_profile = account.build_account_profile(account_profile_params)
      authorize! :manage, @account_profile

      @account_profile.save!
      render json: @account_profile, status: :created
    end

    def update
      @account_profile.update!(account_profile_params)
      render json: @account_profile
    end

    private

    def load_and_authorize_account_profile
      @account_profile = Account.find(params[:account_id]).account_profile
      authorize! :manage, @account_profile
    end

    def account_profile_params
      params.require(:profile).permit(:first_name,
                                      :last_name,
                                      :first_name_kana,
                                      :last_name_kana,
                                      :gender,
                                      :phone,
                                      :postal_code,
                                      :address,
                                      :date_of_birth,
                                      :biography)
    end
  end
end

