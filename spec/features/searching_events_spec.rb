# frozen_string_literal: true

require 'rails_helper'

feature 'searching events', js: true do
  scenario 'user searches by event_type' do
    user = create(:user)
    event_type_1 = create(:event_type, name: 'House Warming', user: user)
    event_1 = create(:event, user: user, event_type: event_type_1)
    event_type_2 = create(:event_type, name: 'Engagement', user: user)
    event_2 = create(:event, user: user, event_type: event_type_2)

    log_in(user)
    click_link(t('layouts.nav_bar.events'))
    click_button(t('events.index.search_events'))
    select(
      event_type_1.name,
      from: t('simple_form.labels.event_search.event_type_id')
    )
    click_button(t('helpers.submit.event_search.create'))

    expect(page).to have_selector('div', class: 'cell', text: event_1.who)
    expect(page).not_to have_selector('div', class: 'cell', text: event_2.who)

    click_button(t('events.index.clear_filters'))

    expect(page).to have_selector('div', class: 'cell', text: event_2.who)
  end

  scenario 'user searches by start_date' do
    user = create(:user)
    event_1 = create(:event, user: user, date: Date.yesterday)
    event_2 = create(:event, user: user, date: Date.tomorrow)

    log_in(user)
    click_link(t('layouts.nav_bar.events'))
    click_button(t('events.index.search_events'))
    fill_in(
      t('simple_form.labels.event_search.start_date'),
      with: input_date(Date.current)
    )
    click_button(t('helpers.submit.event_search.create'))

    expect(page).to have_selector('div', class: 'cell', text: event_2.who)
    expect(page).not_to have_selector('div', class: 'cell', text: event_1.who)

    click_button(t('events.index.clear_filters'))

    expect(page).to have_selector('div', class: 'cell', text: event_1.who)
  end

  scenario 'user searches by end_date' do
    user = create(:user)
    event_1 = create(:event, user: user, date: Date.yesterday)
    event_2 = create(:event, user: user, date: Date.tomorrow)

    log_in(user)
    click_link(t('layouts.nav_bar.events'))
    click_button(t('events.index.search_events'))
    fill_in(
      t('simple_form.labels.event_search.end_date'),
      with: input_date(Date.current)
    )
    click_button(t('helpers.submit.event_search.create'))

    expect(page).to have_selector('div', class: 'cell', text: event_1.who)
    expect(page).not_to have_selector('div', class: 'cell', text: event_2.who)

    click_button(t('events.index.clear_filters'))

    expect(page).to have_selector('div', class: 'cell', text: event_2.who)
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

    expect(page).to have_selector('div', class: 'cell', text: event_1.who)
    expect(page).not_to have_selector('div', class: 'cell', text: event_2.who)

    click_button(t('events.index.clear_filters'))

    expect(page).to have_selector('div', class: 'cell', text: event_2.who)
  end

  scenario 'user submits end_date earlier than start_date' do
    user = create(:user)

    log_in(user)
    click_link(t('layouts.nav_bar.events'))
    click_button(t('events.index.search_events'))
    fill_in(
      t('simple_form.labels.event_search.start_date'),
      with: input_date(Date.tomorrow)
    )
    fill_in(
      t('simple_form.labels.event_search.end_date'),
      with: input_date(Date.yesterday)
    )
    click_button(t('helpers.submit.event_search.create'))

    expect(page).to have_content(
      t(
        'activemodel.errors.models.event_search.attributes.end_date.before_start_date'
      )
    )
  end
end
