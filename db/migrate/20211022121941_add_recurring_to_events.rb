# frozen_string_literal: true

class AddRecurringToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :recurring, :boolean, default: false
  end
end
