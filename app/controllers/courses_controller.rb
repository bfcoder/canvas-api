require 'net/http'

class CoursesController < ApplicationController
  def index
    uri = URI('http://canvas-api.herokuapp.com/api/v1/courses')

    params = { page: 1, access_token: '9be624b4d5206a178fc56921d5bf2c2a' }
    uri.query = URI.encode_www_form(params)

    response = Net::HTTP.get_response(uri)
    @courses = JSON.parse(response.body)

  end
end
