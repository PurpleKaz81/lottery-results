class CreateLotteries < ActiveRecord::Migration[7.1]
  def change
    create_table :lotteries do |t|
      t.string :name
      t.date :draw_date
      t.integer :draw_number

      t.timestamps
    end
  end
end
