# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LotteryApiService do
  describe '.fetch_all_lotteries' do
    it 'fetches all lotteries from the API' do
      stub_request(:get, 'https://loteriascaixa-api.herokuapp.com/api')
        .to_return(body: '[
          "maismilionaria",
          "megasena",
          "lotofacil",
          "quina",
          "lotomania",
          "timemania",
          "duplasena",
          "federal",
          "diadesorte",
          "supersete"
        ]')

      result = described_class.fetch_all_lotteries

      expect(result).to eq(%w[
                             maismilionaria
                             megasena
                             lotofacil
                             quina
                             lotomania
                             timemania
                             duplasena
                             federal
                             diadesorte
                             supersete
                           ])
    end

    it 'handles HTTP errors gracefully' do
      stub_request(:get, 'https://loteriascaixa-api.herokuapp.com/api')
        .to_return(status: 500)

      result = described_class.fetch_all_lotteries

      expect(result).to eq([])
    end
  end

  describe '.fetch_lottery_results' do
    let(:lottery_name) { 'megasena' }
    let(:api_response) do
      JSON.pretty_generate({
                             'loteria' => lottery_name,
                             'concurso' => 2620,
                             'data' => '12/08/2023'
                           })
    end

    before do
      stub_request(:get, "#{LotteryApiService::BASE_URL}/api/#{lottery_name}/latest")
        .to_return(body: api_response)
    end

    it 'fetches the latest results for a specific lottery' do
      result = described_class.fetch_lottery_results(lottery_name)
      expect(result['loteria']).to eq(lottery_name)
      expect(result['concurso']).to eq(2620)
      expect(result['data']).to eq('12/08/2023')
    end

    it 'handles HTTP errors gracefully' do
      stub_request(:get, "#{LotteryApiService::BASE_URL}/api/#{lottery_name}/latest")
        .to_return(status: 500)

      result = described_class.fetch_lottery_results(lottery_name)
      expect(result).to eq([])
    end
  end
end
