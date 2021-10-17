# frozen_string_literal: true

require 'rails_helper'

feature 'creating presents', js: true do
  scenario 'user successfully adds a present' do
    user = create(:user)
    create(:event, user: user)
    present_name = 'Slime Kit'

    log_in(user)
    click_link(I18n.t('layouts.nav_bar.events'))
    click_link(I18n.t('events.index.add_presents'))
    fill_in('present_name', with: present_name)
    click_button(I18n.t('helpers.submit.present.create'))

    expect(page).to have_selector('td', text: present_name)
  end

  scenario 'user submits form without name' do
    user = create(:user)
    event = create(:event, user: user)

    log_in(user)
    visit(event_presents_path(event))
    click_button(I18n.t('helpers.submit.present.create'))

    expect(page).to have_content(I18n.t('errors.messages.blank'))
  end
end
