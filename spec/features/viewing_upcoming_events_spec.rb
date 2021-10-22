# frozen_string_literal: true

require 'rails_helper'

feature 'viewing upcoming events', js: true do
  scenario 'user successfully adds an event' do
    user = create(:user)
    event_1 = create(
      :event,
      user: user,
      date: 2.months.from_now,
      name: 'New Year'
    )
    event_2 = create(
      :event,
      user: user,
      date: 4.months.from_now,
      name: "St Patrick's Day"
    )

    log_in(user)
    click_link(t('layouts.nav_bar.upcoming_events'))
    expect(page).to have_content(event_1.name)
    expect(page).not_to have_content(event_2.name)
  end
end
