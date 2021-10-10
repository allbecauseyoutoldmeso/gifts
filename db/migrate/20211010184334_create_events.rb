# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.date :date, null: false
      t.references :recipient
      t.timestamps
    end
  end
end
