require 'faker'

class Url < ActiveRecord::Base

  before_save :createShortURL

  def createShortURL
    self.short_url = "http://localhost:9393/" << Faker::Base.regexify("[A-Za-z0-9]{5}")
  end
end