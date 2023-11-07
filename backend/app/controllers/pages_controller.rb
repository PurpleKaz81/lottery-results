# frozen_string_literal: true

class PagesController < ApplicationController
  def home
    Rails.logger.info "\n ========== Loaded Home Page ==========\n"
  end

  def index; end
end
