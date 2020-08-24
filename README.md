# README

##  Getting Started

Ruby version: 2.7.1

Rails version: 6.0.3

Depedencies: Docker

Running tests:

  ```ruby
  docker-compose run -e "RAILS_ENV=test" web bundle exec rspec   
  ```
  
## App

This is a real simple rails app where I used --skip for almost everything.

There is no controllers as asked, only models and two services to handle validations.

Pundit has been added to handle authorizations.

Everything has been tested with rspec.


## DB - schema

https://github.com/valentin215/event-app-backend/issues/1#issue-684662698

## Valiations with services

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

Params need this given hash structure:

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
                
## Gems added

'pundit'

'rubocop'

'rspec-rails'

'pundit-matchers'

'shoulda-callback-matchers'

'shoulda-matchers'

## Issues

- I had a small issue with postgres default password in database.yml when I wanted to dockerize the small. The goal was to hide passwords and username inside a .env file. I ran into errors so I decided for the test to let it visible.

