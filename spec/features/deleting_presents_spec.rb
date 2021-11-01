# frozen_string_literal: true

require 'rails_helper'

feature 'deleting presents', js: true do
  scenario 'user successfully deletes a present' do
    user = create(:user)
    event = create(:event, user: user)
    present_1 = create(:present, event: event)
    present_2 = create(:present, event: event)

    log_in(user)
    visit(event_path(event))

    within("#edit_present_#{present_1.id}") do
      click_button(t('helpers.submit.present.delete'))
    end

    expect(page).not_to have_selector('td', text: present_1.name)
    expect(page).to have_selector('td', text: present_2.name)
  end
end
