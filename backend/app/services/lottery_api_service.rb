# frozen_string_literal: true

require 'httparty'

# LotteryApiService is a service class that fetches lottery data from an external API.
class LotteryApiService
  BASE_URL = 'https://loteriascaixa-api.herokuapp.com'

  def self.fetch_all_lotteries
    response = HTTParty.get("#{BASE_URL}/api")
    output_response_details(response)
    parse_response(response)
  rescue HTTParty::Error => e
    puts "HTTParty error occurred: #{e.message}"
    []
  rescue StandardError => e
    puts "An error occurred: #{e.message}"
    []
  end

  def self.fetch_lottery_results(lottery_name)
    response = HTTParty.get("#{BASE_URL}/api/#{lottery_name}/latest")
    output_response_details(response)
    parse_response(response)
  rescue HTTParty::Error => e
    puts "HTTParty error occurred: #{e.message}"
    []
  rescue StandardError => e
    puts "An error occurred: #{e.message}"
    []
  end

  # * helper methods

  def self.output_response_details(response)
    puts JSON.pretty_generate(JSON.parse(response.body)), response.code, response.message, response.headers.inspect
  end

  def self.parse_response(response)
    if response.success?
      JSON.parse(response.body)
    else
      puts "Request failed with code #{response.code}"
      []
    end
  end
end
