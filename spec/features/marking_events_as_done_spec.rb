# frozen_string_literal: true

require 'rails_helper'

feature 'marking events as done', js: true do
  scenario 'user successfully checks off event' do
    user = create(:user)
    event = create(:event, user: user)

    log_in(user)
    click_link(t('layouts.nav_bar.events'))

    within("#edit_event_#{event.id}") do
      expect(page).to have_field('event_state', checked: false)

      check('event_state')
    end

    click_link(t('layouts.nav_bar.events'))

    within("#edit_event_#{event.id}") do
      expect(page).to have_field('event_state', checked: true)
    end
  end
end
