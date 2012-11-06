austere
=======

A gem for defining your API.

Defining your API
=================

The idea behind this is to be able to create a definition for your API
that you can then hook into to easily create documentation in any format
you choose or things such as Lint programs to ensure compliance.

This is an example of what I'm envisioning using a portion of the Instagram API (http://instagram.com/developer/endpoints/users/#get_users)

```ruby
api = Austere::Api.define do |api|
  api.base 'https://api.instagram.com/v1/'

  api.endpoint "users" do |users|
    users.get ":user-id" do |r|
      r.description "Get basic information about a user."

      r.parameter :access_token
      r.parameter :user-id, format: /[0-9]+/

      r.response 200 do |body|
        body.element :data, User
      end
    end
  end
end

class User < Element
  description = 'User data'

  element :id, Integer
  element :username, String
  element :full_name, String
  element :profile_picture, String, format: /^http.*/
  element :bio, String, optional: true
  element :website, String, optional: true
  element :counts, Counts
end

class Counts < Element
  description = "User metrics"

  element :media, Integer
  element :follows, Integer
  element :followed_by, Integer
end
```
