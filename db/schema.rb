# frozen_string_literal: true

ActiveRecord::Schema.define(version: 20_211_026_091_507) do
  enable_extension 'plpgsql'

  create_table 'event_types', force: :cascade do |t|
    t.string 'name', null: false
    t.bigint 'user_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['user_id'], name: 'index_event_types_on_user_id'
  end

  create_table 'events', force: :cascade do |t|
    t.date 'date', null: false
    t.bigint 'recipient_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.boolean 'recurring', default: false
    t.integer 'state', default: 0
    t.bigint 'event_type_id'
    t.index ['event_type_id'], name: 'index_events_on_event_type_id'
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
