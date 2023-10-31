class LotteriesController < ApplicationController
  def index
    FetchLotteryDataJob.perform_later
  end
end
