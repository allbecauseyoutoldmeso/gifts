# frozen_string_literal: true

module Helpers
  def log_in(user)
    visit(root_path)
    fill_in(t('simple_form.labels.user_session.email'), with: user.email)

    fill_in(
      t('simple_form.labels.user_session.password'),
      with: user.password
    )

    click_button(t('helpers.submit.user_session.create'))
  end

  def input_date(date)
    format = ENV['INPUT_DATE_FORMAT'] || '%d/%m/%Y'
    date.strftime(format)
  end

  def t(key, options = {})
    I18n.t(key, **options)
  end
end
