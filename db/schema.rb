# frozen_string_literal: true

ActiveRecord::Schema.define(version: 20_211_022_121_941) do
  enable_extension 'plpgsql'

  create_table 'events', force: :cascade do |t|
    t.string 'name', null: false
    t.date 'date', null: false
    t.bigint 'recipient_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.boolean 'recurring', default: false
    t.index ['recipient_id'], name: 'index_events_on_recipient_id'
  end

  create_table 'presents', force: :cascade do |t|
    t.bigint 'event_id'
    t.string 'name', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['event_id'], name: 'index_presents_on_event_id'
  end

  create_table 'recipients', force: :cascade do |t|
    t.string 'name', null: false
    t.bigint 'user_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['user_id'], name: 'index_recipients_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', null: false
    t.string 'password_digest', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end
end
