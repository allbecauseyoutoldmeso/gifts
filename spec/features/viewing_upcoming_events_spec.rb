# frozen_string_literal: true

require 'rails_helper'

feature 'viewing upcoming events', js: true do
  scenario 'user views upcoming events' do
    user = create(:user)
    event_1 = create(
      :event,
      user: user,
      what: 'Birthday',
      date: 2.months.from_now
    )
    event_2 = create(
      :event,
      user: user,
      what: 'Halloween',
      date: 4.months.from_now
    )

    log_in(user)
    click_link(t('layouts.nav_bar.upcoming_events'))
    expect(page).to have_selector('div', class: 'cell', text: event_1.what)
    expect(page).not_to have_selector('div', class: 'cell', text: event_2.what)
  end
end
