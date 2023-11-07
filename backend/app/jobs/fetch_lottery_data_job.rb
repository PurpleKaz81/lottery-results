# frozen_string_literal: true

class FetchLotteryDataJob < ApplicationJob
  queue_as :default

  def perform(*)
    lottery_names = LotteryApiService.fetch_all_lotteries
    lottery_names.each do |lottery_name|
      lottery = Lottery.find_or_initialize_by(name: lottery_name)
      lottery.save
      Rails.logger.info "Stored lottery #{lottery_name}"
    end
  end
end
