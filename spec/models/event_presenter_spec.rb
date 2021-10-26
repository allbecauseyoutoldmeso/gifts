# frozen_string_literal: true

require 'rails_helper'

describe EventPresenter do
  it_behaves_like 'booleanable' do
    let(:object) { build(:event_presenter) }
    let(:booleanable_attributes) { %i[new_recipient] }
  end

  it_behaves_like 'presentable' do
    let(:presenter) { build(:event_presenter) }
    let(:source) { presenter.send(:event) }

    let(:attributes) do
      {
        date: Date.current,
        recurring: true
      }
    end
  end

  describe '#valid?' do
    it 'is true for factory' do
      event_presenter = build(:event_presenter)
      expect(event_presenter.valid?).to eq(true)
    end

    it 'is false if date is not present' do
      event_presenter = build(:event_presenter, date: nil)

      expect(event_presenter.valid?).to eq(false)

      expect(
        event_presenter.errors.messages[:date]
      ).to contain_exactly(
        t('errors.messages.blank')
      )
    end

    it 'is false if new_recipient is false and recipient_id is not present' do
      event_presenter = build(
        :event_presenter,
        new_recipient: false,
        recipient_id: nil
      )

      expect(event_presenter.valid?).to eq(false)

      expect(
        event_presenter.errors.messages[:recipient_id]
      ).to contain_exactly(
        t('errors.messages.blank')
      )
    end

    it 'is false if new_recipient is true and recipient_name is not present' do
      event_presenter = build(
        :event_presenter,
        new_recipient: true,
        recipient_name: nil
      )

      expect(event_presenter.valid?).to eq(false)

      expect(
        event_presenter.errors.messages[:recipient_name]
      ).to contain_exactly(
        t('errors.messages.blank')
      )
    end

    it 'is false if new_event_type is false and event_type_id is blank' do
      event_presenter = build(
        :event_presenter,
        new_event_type: false,
        event_type_id: nil
      )

      expect(event_presenter.valid?).to eq(false)

      expect(
        event_presenter.errors.messages[:event_type_id]
      ).to contain_exactly(
        t('errors.messages.blank')
      )
    end

    it 'is false if new_event_type is true and event_type_name is blank' do
      event_presenter = build(
        :event_presenter,
        new_event_type: true,
        event_type_name: nil
      )

      expect(event_presenter.valid?).to eq(false)

      expect(
        event_presenter.errors.messages[:event_type_name]
      ).to contain_exactly(
        t('errors.messages.blank')
      )
    end
  end

  describe '#save' do
    it 'creates event for existing recipient' do
      user = create(:user)
      recipient = create(:recipient, user: user)
      event_presenter = build(:event_presenter, user: user)
      attributes = {
        date: Date.current,
        recipient_id: recipient.id,
        new_recipient: false
      }
      event_presenter.attributes = attributes

      expect { event_presenter.save }.to change { user.events.all.count }.by(1)

      expect(user.events.last)
        .to have_attributes(attributes.except(:new_recipient))
    end

    it 'creates event with new recipient' do
      user = create(:user)
      event_presenter = build(:event_presenter, user: user)
      attributes = {
        date: Date.current,
        recipient_name: 'Jane',
        new_recipient: true
      }
      event_presenter.attributes = attributes

      expect { event_presenter.save }
        .to change { user.events.all.count }
        .by(1)
        .and change { user.recipients.all.count }
        .by(1)

      recipient = user.recipients.last

      expect(recipient.name).to eq(attributes[:recipient_name])

      expect(user.events.last).to have_attributes(
        attributes
          .except(:new_recipient, :recipient_name)
          .merge(recipient: recipient)
      )
    end

    it 'creates event for existing event_type' do
      user = create(:user)
      event_type = create(:event_type, user: user)
      event_presenter = build(:event_presenter, user: user)
      attributes = {
        date: Date.current,
        event_type_id: event_type.id,
        new_event_type: false
      }
      event_presenter.attributes = attributes

      expect { event_presenter.save }.to change { user.events.all.count }.by(1)

      expect(user.events.last)
        .to have_attributes(attributes.except(:new_event_type))
    end

    it 'creates event for with new event type' do
      user = create(:user)
      event_presenter = build(:event_presenter, user: user)
      attributes = {
        date: Date.current,
        event_type_name: 'Birthday',
        new_event_type: true
      }
      event_presenter.attributes = attributes

      expect { event_presenter.save }
        .to change { user.events.all.count }
        .by(1)
        .and change { user.event_types.all.count }
        .by(1)

      event_type = user.event_types.last

      expect(event_type.name).to eq(attributes[:event_type_name])

      expect(user.events.last).to have_attributes(
        attributes
          .except(:new_event_type, :event_type_name)
          .merge(event_type: event_type)
      )
    end
  end
end
