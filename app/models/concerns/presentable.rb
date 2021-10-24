# frozen_string_literal: true

module Presentable
  extend ActiveSupport::Concern

  private

  class_methods do
    def presented_attributes(*attributes, source:)
      attributes.each do |attribute|
        delegate(attribute, "#{attribute}=", to: source)
      end
    end
  end
end
