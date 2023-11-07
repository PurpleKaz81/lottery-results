# frozen_string_literal: true

# PagesController handles the actions related to static pages
class PagesController < ApplicationController
  def home
    Rails.logger.info "\n ========== Loaded Home Page ==========\n"
  end

  def index; end
end
