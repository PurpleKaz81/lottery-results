# frozen_string_literal: true

class AddDeviseColumnsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :encrypted_password, :string
    add_column :users, :reset_password_token, :string
    add_column :users, :reset_password_sent_at, :datetime
  end
end
