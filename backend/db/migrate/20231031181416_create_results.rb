# frozen_string_literal: true

class CreateResults < ActiveRecord::Migration[7.1]
  def change
    create_table :results do |t|
      t.references :lottery, null: false, foreign_key: true
      t.integer :number
      t.decimal :prize_amount

      t.timestamps
    end
  end
end
