# frozen_string_literal: true

require 'rails_helper'

feature 'creating events', js: true do
  scenario 'user successfully adds an event' do
    user = create(:user)
    recipient = create(:recipient, user: user)
    event_name = 'Birthday'
    event_date = 1.month.from_now.to_date

    log_in(user)
    click_link(I18n.t('layouts.nav_bar.events'))
    click_button(I18n.t('events.index.add_event'))
    fill_in(I18n.t('simple_form.labels.event.name'), with: event_name)
    fill_in(
      I18n.t('simple_form.labels.event.date'),
      with: input_date(event_date)
    )
    select(
      recipient.name,
      from: I18n.t('simple_form.labels.event.recipient_id')
    )
    click_button(I18n.t('helpers.submit.event.create'))

    expect(page).to have_selector('td', text: event_name)
    expect(page).to have_selector(
      'td',
      text: event_date.strftime("#{event_date.day.ordinalize} %b %y")
    )
    expect(page).to have_selector('td', text: recipient.name)
  end

  scenario 'user submits form with blank fields' do
    user = create(:user)

    log_in(user)
    click_link(I18n.t('layouts.nav_bar.events'))
    click_button(I18n.t('events.index.add_event'))
    click_button(I18n.t('helpers.submit.event.create'))

    within('.event_recipient_id') do
      expect(page).to have_content(I18n.t('errors.messages.blank'))
    end

    within('.event_name') do
      expect(page).to have_content(I18n.t('errors.messages.blank'))
    end

    within('.event_date') do
      expect(page).to have_content(I18n.t('errors.messages.blank'))
    end
  end
end
