# frozen_string_literal: true

require 'rails_helper'

feature 'creating recipients', js: true do
  scenario 'user successfully adds a recipient' do
    user = create(:user)
    recipient_name = 'Jane'

    log_in(user)
    click_link(t('layouts.nav_bar.recipients'))
    fill_in('recipient_name', with: recipient_name)
    click_button(t('helpers.submit.recipient.create'))

    expect(page).to have_selector('td', text: recipient_name)
  end

  scenario 'user submits form without name' do
    user = create(:user)

    log_in(user)
    click_link(t('layouts.nav_bar.recipients'))
    click_button(t('helpers.submit.recipient.create'))

    expect(page).to have_content(t('errors.messages.blank'))
  end
end
