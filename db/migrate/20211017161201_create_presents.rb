# frozen_string_literal: true

class CreatePresents < ActiveRecord::Migration[6.1]
  def change
    create_table :presents do |t|
      t.references :event
      t.string :name, null: false
      t.timestamps
    end
  end
end
