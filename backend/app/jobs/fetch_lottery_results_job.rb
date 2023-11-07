# frozen_string_literal: true

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
    lottery.results.create!(
      contest: results['concurso'],
      date: results['data'],
      numbers: results['resultado']
    )
  end
end
