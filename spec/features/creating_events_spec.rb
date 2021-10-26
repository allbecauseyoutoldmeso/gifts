# frozen_string_literal: true

require 'rails_helper'

feature 'creating events', js: true do
  scenario 'user adds first ever event' do
    user = create(:user)
    recipient_name = 'Sally'
    event_type_name = 'Birthday'
    event_date = 1.month.from_now.to_date

    log_in(user)
    click_link(t('layouts.nav_bar.events'))
    click_button(t('events.index.add_event'))
    fill_in(
      t('simple_form.labels.event_presenter.recipient_name'),
      with: recipient_name
    )
    fill_in(
      t('simple_form.labels.event_presenter.date'),
      with: input_date(event_date)
    )
    fill_in(
      t('simple_form.labels.event_presenter.event_type_name'),
      with: event_type_name
    )
    click_button(t('helpers.submit.event_presenter.create'))

    expect(page).to have_selector('td', text: event_type_name)
    expect(page).to have_selector(
      'td',
      text: event_date.strftime("#{event_date.day.ordinalize} %b %y")
    )
    expect(page).to have_selector('td', text: recipient_name)
  end

  scenario 'user adds event with existing recipient and event_type' do
    user = create(:user)
    recipient = create(:recipient, user: user)
    event_type = create(:event_type, user: user)
    event_date = 1.month.from_now.to_date

    log_in(user)
    click_link(t('layouts.nav_bar.events'))
    click_button(t('events.index.add_event'))

    select(
      recipient.name,
      from: t('simple_form.labels.event_presenter.recipient_id')
    )
    select(
      event_type.name,
      from: t('simple_form.labels.event_presenter.event_type_id')
    )
    fill_in(
      t('simple_form.labels.event_presenter.date'),
      with: input_date(event_date)
    )
    click_button(t('helpers.submit.event_presenter.create'))

    expect(page).to have_selector('td', text: event_type.name)
    expect(page).to have_selector(
      'td',
      text: event_date.strftime("#{event_date.day.ordinalize} %b %y")
    )
    expect(page).to have_selector('td', text: recipient.name)
  end

  scenario 'user adds event with new recipient and event_type' do
    user = create(:user)
    create(:event_type, user: user)
    create(:recipient, user: user)
    recipient_name = 'Sally'
    event_type_name = 'Birthday'
    event_date = 1.month.from_now.to_date

    log_in(user)
    click_link(t('layouts.nav_bar.events'))
    click_button(t('events.index.add_event'))
    check(t('simple_form.labels.event_presenter.new_recipient'))
    fill_in(
      t('simple_form.labels.event_presenter.recipient_name'),
      with: recipient_name
    )
    fill_in(
      t('simple_form.labels.event_presenter.date'),
      with: input_date(event_date)
    )
    check(t('simple_form.labels.event_presenter.new_event_type'))
    fill_in(
      t('simple_form.labels.event_presenter.event_type_name'),
      with: event_type_name
    )
    click_button(t('helpers.submit.event_presenter.create'))

    expect(page).to have_selector('td', text: event_type_name)
    expect(page).to have_selector(
      'td',
      text: event_date.strftime("#{event_date.day.ordinalize} %b %y")
    )
    expect(page).to have_selector('td', text: recipient_name)
  end

  scenario 'user submits form with blank fields' do
    user = create(:user)
    create(:event_type, user: user)
    create(:recipient, user: user)

    log_in(user)
    click_link(t('layouts.nav_bar.events'))
    click_button(t('events.index.add_event'))
    click_button(t('helpers.submit.event_presenter.create'))

    within('.event_presenter_recipient_id') do
      expect(page).to have_content(t('errors.messages.blank'))
    end

    within('.event_presenter_date') do
      expect(page).to have_content(t('errors.messages.blank'))
    end

    within('.event_presenter_event_type_id') do
      expect(page).to have_content(t('errors.messages.blank'))
    end

    check(t('simple_form.labels.event_presenter.new_recipient'))
    check(t('simple_form.labels.event_presenter.new_event_type'))
    click_button(t('helpers.submit.event_presenter.create'))

    within('.event_presenter_recipient_name') do
      expect(page).to have_content(t('errors.messages.blank'))
    end

    within('.event_presenter_event_type_name') do
      expect(page).to have_content(t('errors.messages.blank'))
    end
  end
end
