require 'austere'
require 'pry'
require 'pry-debugger'

class User < Austere::Body
  def initialize
    super do
      description = 'User data'

      element :id, Integer
      element :username, String
      element :full_name, String
      element :profile_picture, String, format: /^http.*/
      element :bio, String, optional: true
      element :website, String, optional: true
      element :counts, Counts
    end
  end
end

class Counts < Austere::Body
  def initialize
    super do
      description = "User metrics"

      element :media, Integer
      element :follows, Integer
      element :followed_by, Integer
    end
  end
end

api = Austere::Api.define do |api|
  api.base = 'https://api.instagram.com/v1/'

  api.endpoint "users" do |users|
    users.get ":user-id" do |r|
      r.description "Get basic information about a user."

      r.parameter :access_token
      r.parameter :user_id, format: /[0-9]+/

      r.response 200 do |body|
        body.element :data, User
      end
    end
  end
end

binding.pry
