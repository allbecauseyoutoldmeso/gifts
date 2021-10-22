# frozen_string_literal: true

require 'rails_helper'

feature 'searching events', js: true do
  scenario 'user searches by name' do
    user = create(:user)
    event_1 = create(:event, user: user, name: 'Birthday')
    event_2 = create(:event, user: user, name: 'New Year')

    log_in(user)
    click_link(t('layouts.nav_bar.events'))
    click_button(t('events.index.search_events'))
    fill_in(t('simple_form.labels.event_search.name'), with: 'Birthday')
    click_button(t('helpers.submit.event_search.create'))

    expect(page).to have_selector('td', text: event_1.name)
    expect(page).not_to have_selector('td', text: event_2.name)
  end

  scenario 'user searches by start_date' do
    user = create(:user)
    event_1 = create(:event, user: user, date: Date.yesterday)
    event_2 = create(:event, user: user, name: Date.tomorrow)

    log_in(user)
    click_link(t('layouts.nav_bar.events'))
    click_button(t('events.index.search_events'))
    fill_in(
      t('simple_form.labels.event_search.start_date'),
      with: input_date(Date.current)
    )
    click_button(t('helpers.submit.event_search.create'))

    expect(page).to have_selector('td', text: event_2.name)
    expect(page).not_to have_selector('td', text: event_1.name)
  end

  scenario 'user searches by end_date' do
    user = create(:user)
    event_1 = create(:event, user: user, date: Date.yesterday)
    event_2 = create(:event, user: user, name: Date.tomorrow)

    log_in(user)
    click_link(t('layouts.nav_bar.events'))
    click_button(t('events.index.search_events'))
    fill_in(
      t('simple_form.labels.event_search.end_date'),
      with: input_date(Date.current)
    )
    click_button(t('helpers.submit.event_search.create'))

    expect(page).to have_selector('td', text: event_1.name)
    expect(page).not_to have_selector('td', text: event_2.name)
  end

  scenario 'user searches by recipient' do
    user = create(:user)
    recipient = create(:recipient, user: user)
    event_1 = create(:event, user: user, recipient: recipient)
    event_2 = create(:event, user: user)

    log_in(user)
    click_link(t('layouts.nav_bar.events'))
    click_button(t('events.index.search_events'))
    select(
      recipient.name,
      from: t('simple_form.labels.event_search.recipient_id')
    )
    click_button(t('helpers.submit.event_search.create'))

    expect(page).to have_selector('td', text: event_1.name)
    expect(page).not_to have_selector('td', text: event_2.name)
  end
end
