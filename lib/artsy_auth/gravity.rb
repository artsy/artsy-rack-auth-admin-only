require 'json'
require 'open-uri'

require 'jwt'
require 'rack/auth/abstract/handler'
require 'rack/auth/abstract/request'

GRAVITY_URL = ENV['GRAVITY_URL']
APPLICATION_ID = ENV['APPLICATION_ID']
APPLICATION_SECRET = ENV['APPLICATION_SECRET']
APPLICATION_INTERNAL_SECRET = ENV['APPLICATION_INTERNAL_SECRET']

REDIRECT_URL = "#{ENV['HOST']}/auth".freeze
OAUTH_REDIRECT = "#{GRAVITY_URL}/oauth2/authorize?client_id=#{APPLICATION_ID}&redirect_uri=#{REDIRECT_URL}&response_type=code".freeze

COOKIE_EXP = Time.now + 7 * 24 * 60 * 60

# Gravity auth code
module ArtsyAuth
  # Generates a URL for the gravity oauth access code which the server gets
  # given after a user successfullly logs in.
  def oauth_url(code)
    query = [
      "client_id=#{APPLICATION_ID}",
      "client_secret=#{APPLICATION_SECRET}",
      "redirect_uri=#{REDIRECT_URL}",
      "code=#{code}",
      'grant_type=authorization_code'
    ]
    "#{GRAVITY_URL}/oauth2/access_token?#{query.join('&')}"
  end

  # An authentication library that uses the JWT and Artsy Oauth
  # to verify whether someone using a site is an admin.
  #
  class Gravity < Rack::Auth::AbstractHandler
    def call(env)
      return authorize(env) if env['REQUEST_PATH'] == '/auth'
      return @app.call(env) if valid?(env)
      unauthorized
    end

    private

    def valid?(env)
      cookies = Rack::Utils.parse_cookies_header(env['HTTP_COOKIE'])
      valid_access_token?(cookies['access_token'])
    end

    def valid_access_token?(access_token)
      return false if access_token.nil?
      jwt, = JWT.decode(access_token, APPLICATION_INTERNAL_SECRET)
      jwt['roles'].split(',').include? 'admin'
    end

    def authorize(env)
      query = Rack::Utils.parse_nested_query(env['QUERY_STRING'])
      code = query['code']
      url = oauth_url(code)
      response = open(url).read
      json = JSON.parse(response)
      return authorized(json) if valid_access_token?(json['access_token'])
      unauthorized
    end

    def authorized(json)
      response = Rack::Response.new
      response.set_cookie('access_token',
                          value: json['access_token'],
                          path: '/',
                          expires: COOKIE_EXP)
      response.redirect '/', 307
      response.finish
    end

    def unauthorized
      response = Rack::Response.new
      response.redirect OAUTH_REDIRECT, 307
      response.finish
    end
  end
end
