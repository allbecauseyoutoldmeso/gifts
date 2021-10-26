# frozen_string_literal: true

class EventPresenter
  include ActiveModel::Model
  include Booleanable
  include Presentable

  attr_accessor(
    :recipient_name,
    :recipient_id,
    :event_type_id,
    :event_type_name
  )

  boolean_attributes :new_recipient, :new_event_type

  presented_attributes :date, :recurring, source: :event

  validates :date, presence: true
  validates :recipient_id, presence: true, unless: :new_recipient
  validates :recipient_name, presence: true, if: :new_recipient
  validates :event_type_id, presence: true, unless: :new_event_type
  validates :event_type_name, presence: true, if: :new_event_type

  def initialize(user)
    @user = user
    @event = user.events.new
  end

  def save
    return false unless valid?

    event.transaction do
      recipient.save
      event_type.save

      event.update(
        recipient: recipient,
        event_type: event_type
      )
    end
  end

  private

  attr_reader :user, :event

  def event_type
    @event_type ||= new_event_type ? build_event_type : find_event_type
  end

  def recipient
    @recipient ||= new_recipient ? build_recipient : find_recipient
  end

  def build_recipient
    user.recipients.new(name: recipient_name)
  end

  def find_recipient
    user.recipients.find(recipient_id)
  end

  def build_event_type
    user.event_types.new(name: event_type_name)
  end

  def find_event_type
    user.event_types.find(event_type_id)
  end
end
