require 'net/http'

class CoursesController < ApplicationController
  def index
    url = "http://canvas-api.herokuapp.com/api/v1/courses?access_token=9be624b4d5206a178fc56921d5bf2c2a"

    uri = URI.parse(url)

    response = Net::HTTP.get_response(uri)
    @courses = JSON.parse(response.body)

  end
end
