require 'net/http'

class CoursesController < ApplicationController
  def index
    uri = URI('http://canvas-api.herokuapp.com/api/v1/courses')

    url_params = { page: params[:page] || 1, access_token: '9be624b4d5206a178fc56921d5bf2c2a' }
    uri.query = URI.encode_www_form(url_params)

    response = Net::HTTP.get_response(uri)
    @courses = JSON.parse(response.body)

    @prev_course_id = params[:page].present? && params[:page].to_i > 1 ? params[:page].to_i - 1 : nil
    @next_course_id = params[:page].present? ? params[:page].to_i + 1 : 2

  end
end
