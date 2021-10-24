# frozen_string_literal: true

shared_examples_for 'presentable' do
  describe '.presented_attributes' do
    it 'delegates write methods to source' do
      presenter.attributes = attributes
      expect(source).to have_attributes(attributes)
    end

    it 'delegates read methods to source' do
      source.attributes = attributes
      expect(presenter).to have_attributes(attributes)
    end
  end
end
