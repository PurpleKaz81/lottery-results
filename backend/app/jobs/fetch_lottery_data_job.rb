# frozen_string_literal: true

# FetchLotteryDataJob is a background job that fetches and stores lottery data.
class FetchLotteryDataJob < ApplicationJob
  queue_as :default
  retry_on StandardError, attempts: 1

  def perform(lottery_name)
    puts 'In FetchLotteryDataJob.perform'
    Rails.logger.info "\n========== Starting FetchLotteryDataJob for #{lottery_name} ==========\n"

    # Fetch the lottery data here...
    results = LotteryApiService.fetch_lottery_results(lottery_name)

    # Update the lottery in the database with the fetched data
    lottery = Lottery.find_by(name: lottery_name)
    new_attributes = map_results_to_lottery_attributes(results)

    if lottery.attributes != new_attributes
      lottery.update!(new_attributes)
    end

    lottery.fetch_data_job_finished!

    Rails.logger.info "\n========== Finished FetchLotteryDataJob for #{lottery_name} ==========\n"
  rescue StandardError => e
    Rails.logger.error "\n========== Error with FetchLotteryDataJob for #{lottery_name}: #{e.message} ==========\n"
  end

  private

  def map_results_to_lottery_attributes(results)
    draw_date = results['dataSorteio'] ? Date.strptime(results['dataSorteio'], '%d/%m/%Y') : nil
    {
      name: results['loteria'],
      draw_date:,
      draw_number: results['concurso']
      # Add more mappings here for the other attributes of the Lottery model...
    }
  end
end
