# frozen_string_literal: true

require 'rails_helper'

feature 'creating events', js: true do
  scenario 'user successfully adds an event' do
    user = create(:user)
    event_1 = create(:event, user: user, date: 2.months.from_now)
    event_2 = create(:event, user: user, date: 4.months.from_now)

    log_in(user)
    click_link(I18n.t('layouts.nav_bar.upcoming_events'))
    expect(page).to have_selector('td', text: event_1.name)
    expect(page).not_to have_selector('td', text: event_2.name)
  end
end
