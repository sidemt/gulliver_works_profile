# frozen_string_literal: true

module V1
  class WorkHistoriesController < ApplicationController
    load_and_authorize_resource only: [:show, :update, :destroy]
    load_and_authorize_resource :account, only: [:index, :create]
    load_and_authorize_resource :work_history, through: :account, only: [:index, :create]

    def index
      render json: @work_histories, include: [:occupation, :industry]
    end

    def show
      render json: @work_history
    end

    def create
      @work_history.save!
      render json: @work_history, status: :created
    end

    def update
      @work_history.update!(work_history_params)
      render json: @work_history
    end

    def destroy
      @work_history.destroy!
      head 204
    end

    private

    def work_history_params
      params.require(:work_history).permit(:is_employed,
                                           :occupation_id,
                                           :industry_id,
                                           :position,
                                           :annual_income,
                                           :management_experience,
                                           :job_summary,
                                           :since_date,
                                           :until_date,
                                           :name)
    end
  end
end
