require 'rails_helper'

RSpec.describe UserCustomAttributesValidator do
  before(:each) do
    params = { name: 'test name',
               password: '1234567',
               user_custom_attributes:
                {
                  '1': { content: 'some content' },
                  '2': { content: 'ok content' },
                  '24': { content: 'ok content' }
                } }
    @validator = UserCustomAttributesValidator.new(params)
  end

  context 'on create' do
    it 'should return true to pass the creation when there is no required attributes on signup' do
      validation = @validator.on_create
      expect(validation).to eq(true)
    end

    it 'should return false when there is no matching ids' do
      CustomAttribute.create(
        id: 2345,
        name: 'teddst',
        for_event_registration: false,
        for_user: true,
        required_for_signup: true,
        required_for_event_form: false,
        attribute_type: 'boolean'
      )
      validation = @validator.on_create
      expect(validation).to eq(false)
    end

    it 'should return true when there is matching ids' do
      CustomAttribute.create(
        id: 24,
        name: 'teddst',
        for_event_registration: false,
        for_user: true,
        required_for_signup: true,
        required_for_event_form: false,
        attribute_type: 'boolean'
      )
      validation = @validator.on_create
      expect(validation).to eq(true)
    end
  end

  context 'on update' do
    it 'should return true to pass the creation when there is no required attributes on the profile' do
      validation = @validator.on_update
      expect(validation).to eq(true)
    end

    it 'should return false when there is not matching ids' do
      CustomAttribute.create(
        id: 232,
        name: 'teddst',
        for_event_registration: false,
        for_user: true,
        required_for_profile: true,
        required_for_event_form: false,
        attribute_type: 'boolean'
      )
      validation = @validator.on_update
      expect(validation).to eq(false)
    end

    it 'should return true when there is matching ids' do
      CustomAttribute.create(
        id: 24,
        name: 'teddst',
        for_event_registration: false,
        for_user: true,
        required_for_profile: true,
        required_for_event_form: false,
        attribute_type: 'boolean'
      )
      validation = @validator.on_update
      expect(validation).to eq(true)
    end
  end
end
