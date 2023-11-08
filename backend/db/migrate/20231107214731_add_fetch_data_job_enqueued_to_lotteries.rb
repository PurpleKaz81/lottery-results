# frozen_string_literal: true

# This migration adds a `fetch_data_job_enqueued` column to the `lotteries` table.
# The new column is a boolean that indicates whether a FetchLotteryDataJob is currently enqueued for a lottery.
# The column's default value is `false`; by default, a FetchLotteryDataJob is not enqueued for a lottery.
class AddFetchDataJobEnqueuedToLotteries < ActiveRecord::Migration[7.1]
  def change
    add_column :lotteries, :fetch_data_job_enqueued, :boolean, default: false
  end
end
