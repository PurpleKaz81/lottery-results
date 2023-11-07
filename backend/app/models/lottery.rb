# frozen_string_literal: true

# Lottery is a model that represents a lottery. It has many results and enqueues a job to fetch lottery data after save.
class Lottery < ApplicationRecord
  has_many :results

  after_save :enqueue_fetch_lottery_data_job

  private

  def enqueue_fetch_lottery_data_job
    Rails.logger.info "About to enqueue FetchLotteryDataJob for #{name}"
    FetchLotteryDataJob.perform_later(name)
    Rails.logger.info "Enqueued FetchLotteryDataJob for #{name}"
  end
end
