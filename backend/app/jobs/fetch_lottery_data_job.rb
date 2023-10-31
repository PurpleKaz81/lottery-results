# frozen_string_literal: true

class FetchLotteryDataJob < ApplicationJob
  queue_as :default

  def perform(*)
    LotteryApiService.fetch_all_lotteries
  end

  # Remember to enqueue the job somewhere in your application with FetchLotteryDataJob.perform_later. This will add the job to the queue, and it will be performed as soon as the queueing system is free to process it.
end
