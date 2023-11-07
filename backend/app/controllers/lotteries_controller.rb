# frozen_string_literal: true

class LotteriesController < ApplicationController
  def index
    lottery_names
  end

  def show
    @lottery_name = params[:id]
    @lottery = Lottery.find_by(name: @lottery_name)
    @display_name = alter_name(@lottery_name)
    lottery_names
  end

  private

  def lottery_names
    @lottery_names = LotteryApiService.fetch_all_lotteries
  end

  def alter_name(lottery)
    lottery_names = {
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
    }
    lottery_names[lottery]
  end
end
