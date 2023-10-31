class LotteriesController < ApplicationController
  def index
    FetchLotteryDataJob.perform_later

    @lottery_names = LotteryApiService.fetch_all_lotteries
  end
end
