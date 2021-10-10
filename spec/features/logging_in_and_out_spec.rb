# frozen_string_literal: true

require 'rails_helper'

feature 'logging in and out' do
  scenario 'user logs in and out successfully' do
    user = create(:user)
    visit(root_path)

    expect(page).to have_current_path(new_user_session_path, ignore_query: true)

    fill_in(I18n.t('simple_form.labels.user_session.email'), with: user.email)
    fill_in(
      I18n.t('simple_form.labels.user_session.password'),
      with: user.password
    )
    click_button(I18n.t('helpers.submit.user_session.create'))

    expect(page).to have_current_path(root_path, ignore_query: true)

    click_button(I18n.t('layouts.nav_bar.log_out'))

    expect(page).to have_current_path(new_user_session_path, ignore_query: true)
  end

  scenario 'user submits form with no email' do
    user = create(:user)
    visit(new_user_session_path)
    fill_in(
      I18n.t('simple_form.labels.user_session.password'),
      with: user.password
    )
    click_button(I18n.t('helpers.submit.user_session.create'))

    within('.user_session_email') do
      expect(page).to have_content(I18n.t('errors.messages.blank'))
    end
  end

  scenario 'user submits form with no password' do
    user = create(:user)
    visit(new_user_session_path)
    fill_in(I18n.t('simple_form.labels.user_session.email'), with: user.email)
    click_button(I18n.t('helpers.submit.user_session.create'))

    within('.user_session_password') do
      expect(page).to have_content(I18n.t('errors.messages.blank'))
    end
  end

  scenario 'user submits form with invalid log in credentials' do
    user = create(:user)
    visit(new_user_session_path)
    fill_in(I18n.t('simple_form.labels.user_session.email'), with: user.email)
    fill_in(
      I18n.t('simple_form.labels.user_session.password'),
      with: 'wrongpassword'
    )
    click_button(I18n.t('helpers.submit.user_session.create'))

    expect(page).to have_content(
      I18n.t(
        'activemodel.errors.models.user_session.attributes.base.invalid_credentials'
      )
    )
  end
end
