# frozen_string_literal: true

class RecipientsController < ApplicationController
  before_action :assign_recipients

  def index
    @new_recipient = recipients.new
  end

  def create
    recipient = recipients.new(recipient_params)
    @new_recipient = recipient.save ? recipients.new : recipient
    render(json: { html: render_to_string('recipients/index') })
  end

  private

  attr_reader :recipients

  def assign_recipients
    @recipients = current_user.recipients.persisted
  end

  def recipient_params
    params.require(:recipient).permit(:name)
  end
end
