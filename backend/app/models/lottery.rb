# frozen_string_literal: true

# Lottery is a model that represents a lottery. It has many results and enqueues a job to fetch lottery data after save.
class Lottery < ApplicationRecord
  has_many :results

  def fetch_data_job_enqueued!
    update_column(:fetch_data_job_enqueued, true)
  end

  def fetch_data_job_finished!
    update_column(:fetch_data_job_enqueued, false)
  end
end
