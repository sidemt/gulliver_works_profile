# frozen_string_literal: true

module V1
  class AccountProfilesController < ApplicationController
    load_and_authorize_resource :account
    load_and_authorize_resource singleton: true, through: :account

    def show
      render json: @account_profile
    end

    def create
      @account_profile.save!
      render json: @account_profile, status: :created
    end

    def update
      @account_profile.update!(account_profile_params)
      render json: @account_profile
    end

    private

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

