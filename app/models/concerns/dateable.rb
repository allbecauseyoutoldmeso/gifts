# frozen_string_literal: true

module Dateable
  extend ActiveSupport::Concern

  private

  class_methods do
    def date_attributes(*attributes)
      attributes.each do |attribute|
        define_method "#{attribute}=" do |value|
          parsed_value = value&.to_date || nil
          instance_variable_set("@#{attribute}", parsed_value)
        end

        attr_reader attribute
      end
    end
  end
end
