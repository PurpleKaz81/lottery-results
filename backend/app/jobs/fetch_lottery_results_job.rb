# frozen_string_literal: true

# FetchLotteryResultsJob is a background job that fetches and stores lottery results.
class FetchLotteryResultsJob < ApplicationJob
  queue_as :default

  def perform(*)
    Lottery.find_each do |lottery|
      results = LotteryApiService.fetch_lottery_results(lottery.name)
      if results.present?
        store_results(lottery, results)
        Rails.logger.info "Stored results for #{lottery.name}"
      else
        Rails.logger.warn "No results found for #{lottery.name}"
      end
    end
  end

  private

  def store_results(lottery, results)
    lottery.results.create(
      contest: results['concurso'],
      date: results['data'],
      numbers: results['dezenas']
    )

    return if result.peristed?

    Rails.logger.warn "Failed to store results for #{lottery.name}"
  end
end
