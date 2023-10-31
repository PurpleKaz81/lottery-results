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
end
