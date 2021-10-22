# frozen_string_literal: true

require 'rails_helper'

feature 'creating events', js: true do
  scenario 'user successfully adds an event' do
    user = create(:user)
    recipient = create(:recipient, user: user)
    event_name = 'Birthday'
    event_date = 1.month.from_now.to_date

    log_in(user)
    click_link(t('layouts.nav_bar.events'))
    click_button(t('events.index.add_event'))
    fill_in(t('simple_form.labels.event.name'), with: event_name)
    fill_in(
      t('simple_form.labels.event.date'),
      with: input_date(event_date)
    )
    select(
      recipient.name,
      from: t('simple_form.labels.event.recipient_id')
    )
    check(t('simple_form.labels.event.recurring'))
    click_button(t('helpers.submit.event.create'))

    expect(page).to have_selector('td', text: event_name)
    expect(page).to have_selector(
      'td',
      text: event_date.strftime("#{event_date.day.ordinalize} %b %y")
    )
    expect(page).to have_selector('td', text: t('events.index.recurring'))
    expect(page).to have_selector('td', text: recipient.name)
  end

  scenario 'user submits form with blank fields' do
    user = create(:user)

    log_in(user)
    click_link(t('layouts.nav_bar.events'))
    click_button(t('events.index.add_event'))
    click_button(t('helpers.submit.event.create'))

    within('.event_recipient_id') do
      expect(page).to have_content(t('errors.messages.blank'))
    end

    within('.event_name') do
      expect(page).to have_content(t('errors.messages.blank'))
    end

    within('.event_date') do
      expect(page).to have_content(t('errors.messages.blank'))
    end
  end
end
