# frozen_string_literal: true

shared_examples_for 'dateable' do
  describe '.date_attributes' do
    it 'converts parseable strings to dates' do
      date = Date.current

      dateable_attributes.each do |attribute|
        object.send("#{attribute}=", date.to_s)
        expect(object.send(attribute)).to eq(date)
      end
    end

    it 'converts blank values to nil' do
      dateable_attributes.each do |attribute|
        object.send("#{attribute}=", '')
        expect(object.send(attribute)).to eq(nil)
      end
    end

    it 'accepts dates' do
      date = Date.current

      dateable_attributes.each do |attribute|
        object.send("#{attribute}=", date)
        expect(object.send(attribute)).to eq(date)
      end
    end
  end
end
