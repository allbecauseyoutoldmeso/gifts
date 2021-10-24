# frozen_string_literal: true

class EventPresenter
  include ActiveModel::Model
  include Booleanable
  include Presentable

  attr_accessor :recipient_name, :recipient_id

  boolean_attributes :new_recipient

  presented_attributes :name, :date, :recurring, source: :event

  validates :name, :date, presence: true
  validates :recipient_id, presence: true, unless: :new_recipient
  validates :recipient_name, presence: true, if: :new_recipient

  def initialize(user)
    @user = user
    @event = user.events.new
  end

  def save
    return false unless valid?

    event.transaction do
      recipient.save
      event.update(recipient: recipient)
    end
  end

  private

  attr_reader :user, :event

  def recipient
    @recipient ||= new_recipient ? build_recipient : find_recipient
  end

  def build_recipient
    user.recipients.new(name: recipient_name)
  end

  def find_recipient
    user.recipients.find(recipient_id)
  end
end
