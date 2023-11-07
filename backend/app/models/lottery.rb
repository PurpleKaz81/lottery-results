# frozen_string_literal: true

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
