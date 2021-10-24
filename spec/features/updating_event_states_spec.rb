# frozen_string_literal: true

require 'rails_helper'

feature 'updating_event_states', js: true do
  scenario 'user successfully checks off event' do
    user = create(:user)
    event = create(:event, user: user, state: Event.states[:pending])

    log_in(user)
    click_link(t('layouts.nav_bar.events'))

    within("#edit_event_#{event.id}") do
      select(
        t('activerecord.attributes.event.states.purchased'),
        from: 'event_state'
      )
    end

    click_link(t('layouts.nav_bar.events'))

    within("#edit_event_#{event.id}") do
      expect(page).to have_select(
        'event_state',
        selected: t('activerecord.attributes.event.states.purchased')
      )
    end
  end
end
