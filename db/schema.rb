# frozen_string_literal: true

ActiveRecord::Schema.define(version: 20_211_010_154_754) do
  enable_extension 'plpgsql'

  create_table 'users', force: :cascade do |t|
    t.string 'email', null: false
    t.string 'password_digest', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end
end
