# frozen_string_literal: true

class Result < ApplicationRecord
  belongs_to :lottery
  has_one :prize_breakdown
end
