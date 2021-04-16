# frozen_string_literal: true

module V1
  class AcademicHistoriesController < ApplicationController
    load_and_authorize_resource :account, only: [:index, :create]
    load_and_authorize_resource :academic_history, through: :account, shallow: true

    def index
      render json: @academic_histories
    end

    def show
      render json: @academic_history
    end

    def create
      @academic_history.save!
      render json: @academic_history, status: :created
    end

    def update
      @academic_history.update!(resource_params)
      render json: @academic_history
    end

    def destroy
      @academic_history.destroy!
      head 204
    end

    private

    def resource_params
      params.require(:academic_history).permit(:name,
                                               :faculty,
                                               :since_date,
                                               :until_date,
                                               :type)
    end
  end
end
