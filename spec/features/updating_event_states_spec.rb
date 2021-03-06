# frozen_string_literal: true

require 'rails_helper'

feature 'updating_event_states', js: true do
  scenario 'user successfully checks off event' do
    user = create(:user)
    event = create(:event, user: user, state: Event.states[:pending])

    log_in(user)
    click_link(t('layouts.nav_bar.events'))
    click_link(event.what)

    select(
      t('activerecord.attributes.event.states.purchased'),
      from: 'event_state'
    )

    click_link(t('layouts.nav_bar.events'))

    event_row = find('a', class: 'row', text: event.what)

    within(event_row) do
      expect(page).to have_selector('i', class: 'fa-shopping-bag')
    end
  end
end
