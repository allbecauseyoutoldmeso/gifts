# frozen_string_literal: true

class CreateRecipients < ActiveRecord::Migration[6.1]
  def change
    create_table :recipients do |t|
      t.string :name, null: false
      t.references :user
      t.timestamps
    end
  end
end
