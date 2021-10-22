# frozen_string_literal: true

require 'rails_helper'

describe EventSearch do
  it_behaves_like 'dateable' do
    let(:object) { build(:event_search) }
    let(:dateable_attributes) { %i[start_date end_date] }
  end

  describe '#valid?' do
    it 'is true for factory' do
      event_search = build(:event_search)
      expect(event_search.valid?).to eq(true)
    end
  end

  describe '#events' do
    it 'returns events filtered by case-insensitive name' do
      user = create(:user)
      event_1 = create(:event, user: user, name: 'Christmas')
      event_2 = create(:event, user: user, name: 'christmas')
      event_3 = create(:event, user: user, name: 'CHRISTMAS')
      _event_4 = create(:event, user: user, name: 'Birthday')
      event_search = build(:event_search, user: user, name: 'Christmas')

      expect(event_search.results).to contain_exactly(event_1, event_2, event_3)
    end

    it 'returns events filtered by start date' do
      user = create(:user)
      _event_1 = create(:event, user: user, date: 3.days.ago)
      event_2 = create(:event, user: user, date: 2.days.ago)
      event_3 = create(:event, user: user, date: 1.day.ago)
      event_search = build(:event_search, user: user, start_date: 2.days.ago)

      expect(event_search.results).to contain_exactly(event_2, event_3)
    end

    it 'returns events filtered by end date' do
      user = create(:user)
      event_1 = create(:event, user: user, date: 3.days.ago)
      event_2 = create(:event, user: user, date: 2.days.ago)
      _event_3 = create(:event, user: user, date: 1.day.ago)
      event_search = build(:event_search, user: user, end_date: 2.days.ago)

      expect(event_search.results).to contain_exactly(event_1, event_2)
    end

    it 'returns events filtered by recipient_id' do
      user = create(:user)
      recipient = create(:recipient, user: user)
      event_1 = create(:event, recipient: recipient)
      _event_2 = create(:event, user: user)
      event_search = build(
        :event_search,
        user: user,
        recipient_id: recipient.id
      )

      expect(event_search.results).to contain_exactly(event_1)
    end
  end
end
