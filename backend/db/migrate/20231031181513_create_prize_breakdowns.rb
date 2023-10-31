# frozen_string_literal: true

class CreatePrizeBreakdowns < ActiveRecord::Migration[7.1]
  def change
    create_table :prize_breakdowns do |t|
      t.references :result, null: false, foreign_key: true
      t.string :prize_category
      t.integer :winners_count
      t.decimal :prize_amount

      t.timestamps
    end
  end
end
