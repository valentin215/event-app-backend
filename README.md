# README

# DB - SCHEMA

https://github.com/valentin215/event-app-backend/issues/1#issue-684662698

# VALIATIONS WITH SERVICES

When an Admin decide to create a CustomAttribute with required_on_signup / required_on_profile or required_on_event_form, validations are handled inside the controller with services as validators.

Inside the controller when creating user, just pass the params as arguments:

```ruby
def  create
  if UserCustomAttributesValidator.call_on_create(params).valid?
    create_user
    create_user_custom_attribute_values
  else
    error
  end 
end 
```

when updating a user, use:

```ruby
UserCustomAttributesValidator.call_on_update(params).valid?
```

when creating an event registration and event_custom_attribute_values:

```ruby
EventCustomAttributesValidator.call(params).valid?
```

Params needs this given hash structure:

```ruby
params = { name: 'test name',
               password: '1234567',
               event_custom_attributes:
                {
                  '1': { content: 'some content' },
                  '2': { content: 'some content' },
                  '3': { content: 'some content' }
                },
               user_custom_attributes:
                {
                  '4': { content: 'some content' },
                  '5': { content: 'ok content' },
                  '6': { content: 'ok content' }
                } }
```
                



# 
