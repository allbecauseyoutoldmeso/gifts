# frozen_string_literal: true

require 'rails_helper'

feature 'creating events', js: true do
  scenario 'user successfully adds an event' do
    user = create(:user)
    recipient = create(:recipient, user: user)
    event_name = 'Birthday'
    event_date = 1.month.from_now.to_date

    log_in(user)
    visit(events_path)
    fill_in(I18n.t('simple_form.labels.event.name'), with: event_name)
    fill_in(
      I18n.t('simple_form.labels.event.date'),
      with: event_date.strftime('%d/%m/%Y')
    )
    select(
      recipient.name,
      from: I18n.t('simple_form.labels.event.recipient_id')
    )
    click_button(I18n.t('helpers.submit.event.create'))

    expect(page).to have_selector('td', text: event_name)
    expect(page).to have_selector(
      'td',
      text: event_date.strftime("#{event_date.day.ordinalize} of %B %Y")
    )
    expect(page).to have_selector('td', text: recipient.name)
  end
end
