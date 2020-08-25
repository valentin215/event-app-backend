require 'rails_helper'

RSpec.describe EventCustomAttributesValidator do
  before(:each) do
    params = { name: 'test name',
               password: '1234567',
               event_id: 1,
               event_custom_attributes:
                {
                  '1': { content: 'some content' },
                  '2': { content: 'ok content' },
                  '2345': { content: 'ok content' }
                } }
    @validator = EventCustomAttributesValidator.new(params)
  end

  context 'on registration form' do
    it 'should return true to pass the creation when there is no required attributes for an event registration' do
      validation = @validator.on_registration
      expect(validation).to eq(true)
    end

    it 'should return false when there is no matching ids' do
      Event.create(id: 1, name: 'test event')
      CustomAttribute.create(
        id: 34,
        event_id: 1,
        name: 'test',
        for_event_registration: true,
        for_user: false,
        required_for_signup: false,
        required_for_event_form: true,
        attribute_type: 'boolean'
      )
      validation = @validator.on_registration
      expect(validation).to eq(false)
    end

    it 'should return true when there is matching ids' do
      Event.create(id: 1, name: 'test event')
      CustomAttribute.create(
        id: 2345,
        event_id: 1,
        name: 'test',
        for_event_registration: true,
        for_user: false,
        required_for_signup: false,
        required_for_event_form: true,
        attribute_type: 'boolean'
      )
      validation = @validator.on_registration
      expect(validation).to eq(true)
    end
  end
end
