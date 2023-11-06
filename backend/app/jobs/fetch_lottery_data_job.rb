# frozen_string_literal: true

class FetchLotteryDataJob < ApplicationJob
  queue_as :default

  def perform(*)
    lottery_names = LotteryApiService.fetch_all_lotteries
    lottery_names.each do |lottery_name|
      Lottery.find_or_create_by(name: lottery_name)
    end
  end

  # Remember to enqueue the job somewhere in your application with FetchLotteryDataJob.perform_later. This will add the job to the queue, and it will be performed as soon as the queueing system is free to process it.
end
