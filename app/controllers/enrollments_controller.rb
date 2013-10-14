require 'net/http'
require 'json'
require 'uri'

class EnrollmentsController < ApplicationController
  def index
  end
  def create
    url = 'http://canvas-api.herokuapp.com/api/v1/courses/' + params[:course_id] + '/enrollments'
    uri = URI(url)

    url_params = { access_token: '9be624b4d5206a178fc56921d5bf2c2a' }
    uri.query = URI.encode_www_form(url_params)

    req = Net::HTTP::Post.new uri
    req.body = {"user" => params[:user]}.to_json
    req.content_type = 'application/json'
    # req.set_form_data({"user" => params[:user]})

    response = Net::HTTP.start(uri.host, uri.port) do |http|
      http.request req
    end

    # response = Net::HTTP.post_form(uri, {"user" => params[:user]})

    puts params[:user]
    puts response.body

    redirect_to :back
  end
end
