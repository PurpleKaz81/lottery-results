# frozen_string_literal: true

class FetchLotteryResultsJob < ApplicationJob
  queue_as :default

  def perform(*)
    Lottery.all.each do |lottery|
      result_data = LotteryApiService.fetch_lottery_results(lottery)
      Rails.logger.info "====== Result Data for #{lottery.name}: #{result_data} ======"
    end
  end
end
