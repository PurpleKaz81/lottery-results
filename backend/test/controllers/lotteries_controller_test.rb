# frozen_string_literal: true

require 'test_helper'

class LotteryControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get lottery_index_url
    assert_response :success
  end
end
