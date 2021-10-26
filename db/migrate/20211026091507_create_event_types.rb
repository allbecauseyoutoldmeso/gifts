# frozen_string_literal: true

class CreateEventTypes < ActiveRecord::Migration[6.1]
  def up
    create_table :event_types do |t|
      t.string :name, null: false
      t.references :user
      t.timestamps
    end

    add_reference :events, :event_type, index: true

    execute(
      "INSERT INTO event_types (name, user_id, created_at, updated_at)
       SELECT DISTINCT events.name, recipients.user_id, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
       FROM events
       JOIN recipients ON events.recipient_id = recipients.id;"
    )

    execute(
      "UPDATE events
      SET event_type_id = event_types.id
      FROM event_types
      WHERE events.name = event_types.name;"
    )

    remove_column :events, :name
  end

  def down
    add_column :events, :name, :string

    execute(
      "UPDATE events
      SET name = event_types.name
      FROM event_types
      WHERE events.event_type_id = event_types.id;"
    )

    remove_reference :events, :event_type
    drop_table :event_types
  end
end
