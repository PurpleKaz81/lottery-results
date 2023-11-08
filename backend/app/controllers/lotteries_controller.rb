# frozen_string_literal: true

# LotteriesController handles the actions related to Lotteries.
class LotteriesController < ApplicationController
  LOTTERY_NAMES = {
    'maismilionaria' => 'Mais Milionária',
    'megasena' => 'Mega Sena',
    'lotofacil' => 'Loto Fácil',
    'quina' => 'Quina',
    'lotomania' => 'Loto Mania',
    'timemania' => 'Time Mania',
    'duplasena' => 'Dupla Sena',
    'federal' => 'Federal',
    'diadesorte' => 'Dia de Sorte',
    'supersete' => 'Super Sete'
  }.freeze

  def index
    Rails.logger.info "\n ========== User navigated to lotteries index page ========== \n"
    lottery_names
  end

  def show
    @lottery_name = params[:id]
    @lottery = Lottery.find_by(name: @lottery_name)
    @display_name = alter_name(@lottery_name)

    Rails.logger.info "\n========== About to enqueue FetchLotteryDataJob for #{@lottery_name} ==========\n"
    @lottery.fetch_data_job_enqueued!
    FetchLotteryDataJob.perform_later(@lottery_name)
    Rails.logger.info "\n========== Enqueued FetchLotteryDataJob for #{@lottery_name} ==========\n"

    Rails.logger.info "\n ========== User navigated to lotteries show page for #{@lottery_name} ========== \n"
  end

  private

  def lottery_names
    @lottery_names = LotteryApiService.fetch_all_lotteries
  end

  def alter_name(lottery)
    LOTTERY_NAMES[lottery]
  end
end
