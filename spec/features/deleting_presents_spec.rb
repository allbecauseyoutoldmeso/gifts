# frozen_string_literal: true

require 'rails_helper'

feature 'deleting presents', js: true do
  scenario 'user successfully deletes a present' do
    user = create(:user)
    event = create(:event, user: user)
    present_1 = create(:present, event: event)
    present_2 = create(:present, event: event)

    log_in(user)
    visit(event_presents_path(event))
    present_1_row = find('tr', text: present_1.name)

    within(present_1_row) do
      click_button(t('presents.index.delete'))
    end

    expect(page).not_to have_selector('td', text: present_1.name)
    expect(page).to have_selector('td', text: present_2.name)
  end
end
