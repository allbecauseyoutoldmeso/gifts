# frozen_string_literal: true

shared_examples_for 'booleanable' do
  describe '.boolean_attributes' do
    it 'converts 0 to false' do
      booleanable_attributes.each do |attribute|
        object.send("#{attribute}=", 0)
        expect(object.send(attribute)).to eq(false)
      end
    end

    it 'converts 1 to true' do
      booleanable_attributes.each do |attribute|
        object.send("#{attribute}=", 1)
        expect(object.send(attribute)).to eq(true)
      end
    end

    it "converts '0' to false" do
      booleanable_attributes.each do |attribute|
        object.send("#{attribute}=", '0')
        expect(object.send(attribute)).to eq(false)
      end
    end

    it "converts '1' to true" do
      booleanable_attributes.each do |attribute|
        object.send("#{attribute}=", '1')
        expect(object.send(attribute)).to eq(true)
      end
    end

    it "converts 'false' to false" do
      booleanable_attributes.each do |attribute|
        object.send("#{attribute}=", 'false')
        expect(object.send(attribute)).to eq(false)
      end
    end

    it "converts 'true' to true" do
      booleanable_attributes.each do |attribute|
        object.send("#{attribute}=", 'true')
        expect(object.send(attribute)).to eq(true)
      end
    end

    it 'accepts false' do
      booleanable_attributes.each do |attribute|
        object.send("#{attribute}=", false)
        expect(object.send(attribute)).to eq(false)
      end
    end

    it 'accepts true' do
      booleanable_attributes.each do |attribute|
        object.send("#{attribute}=", true)
        expect(object.send(attribute)).to eq(true)
      end
    end
  end
end
