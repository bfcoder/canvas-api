require 'net/http'
require 'link_header'
require 'cgi'

class CoursesController < ApplicationController
  def index
    uri = URI('http://canvas-api.herokuapp.com/api/v1/courses')

    url_params = { page: params[:page] || 1, access_token: '9be624b4d5206a178fc56921d5bf2c2a' }
    uri.query = URI.encode_www_form(url_params)

    response = Net::HTTP.get_response(uri)

    @courses = JSON.parse(response.body)

    link = LinkHeader.parse(response['link']).to_a

    link.map do |zelda|
      if zelda[1] == [["rel", "first"]]
        @first_course = zelda[0]
      end
      if zelda[1] == [["rel", "prev"]]
        @prev_course = zelda[0]
      end
      if zelda[1] == [["rel", "next"]]
        @next_course = zelda[0]
      end
      if zelda[1] == [["rel", "last"]]
        @last_course = zelda[0]
      end
    end
    prev_course_info = URI.parse(@prev_course) if @prev_course
    if prev_course_info
      prev_course_query = prev_course_info.query
    end
    next_course_info = URI.parse(@next_course) if @next_course
    if next_course_info
      next_course_query = next_course_info.query
    end

    @prev_course_id = @prev_course.nil? ? nil : prev_course_query.present? ? CGI::parse(prev_course_query)['page'][0] : nil
    @next_course_id = @next_course.nil? ? nil : next_course_query.present? ? CGI::parse(next_course_query)['page'][0] : nil

  end

  def show
    url = 'http://canvas-api.herokuapp.com/api/v1/courses/' + params[:id]
    uri = URI(url)

    url_params = { page: params[:page] || 1, access_token: '9be624b4d5206a178fc56921d5bf2c2a' }
    uri.query = URI.encode_www_form(url_params)

    response = Net::HTTP.get_response(uri)

    @course = JSON.parse(response.body)
  end
end
