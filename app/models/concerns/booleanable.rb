# frozen_string_literal: true

module Booleanable
  extend ActiveSupport::Concern

  private

  class_methods do
    def boolean_attributes(*attributes)
      attributes.each do |attribute|
        define_method "#{attribute}=" do |value|
          instance_variable_set(
            "@#{attribute}",
            ActiveModel::Type::Boolean.new.cast(value)
          )
        end

        attr_reader attribute
      end
    end
  end
end
