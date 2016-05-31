require 'uri'
require 'json'
require 'rest_client'
require 'jwt'

require_relative "./errors.rb"
require_relative "./v2/game.rb"

module PlaylyfeClient
  #based on playlyfe-rub-sdk (https://github.com/playlyfe/playlyfe-ruby-sdk)
  class Connection
    attr_reader :sdk_version

    def self.createJWT(options)
      options[:scopes] ||= []
      options[:expires] ||= 3600
      expires = Time.now.to_i + options[:expires]
      token = JWT.encode({:player_id => options[:player_id], :scopes => options[:scopes], :exp => expires}, options[:client_secret], 'HS256')
      token = "#{options[:client_id]}:#{token}"
      return token
    end

    def initialize(options = {})
      if options[:type].nil?
        err = PlaylyfeClient::ConnectionError.new("")
        err.name = 'init_failed'
        err.message = "You must pass in a type whether 'client' for client credentials flow or 'code' for auth code flow"
        raise err
      end
      @version = options[:version] ||= 'v2'
      @type = options[:type]
      @id = options[:client_id]
      @secret = options[:client_secret]
      @store = options[:store]
      @load = options[:load]
      @redirect_uri = options[:redirect_uri]
      if @store.nil?
        @store = lambda { |token| puts 'Storing Token' }
      end
      if @type == 'client'
        get_access_token()
      else
        if options[:redirect_uri].nil?
          err = PlaylyfeClient::ConnectionError.new("")
          err.name = 'init_failed'
          err.message = 'You must pass in a redirect_uri for the auth code flow'
          raise err
        end
      end
    end

    def api_version
      @version
    end

    def game
      fail PlaylyfeClient::GameError.new("{\"error\": \"unsupported version of API\", \"error_description\": \"'#{self.api_version}' of API is unsupported by playlyfe_client\"}")
    end 
      
    def get_access_token
      begin
        if @type == 'client'
          access_token = RestClient::Request.execute(:method => :post, :url => 'https://playlyfe.com/auth/token',
            :payload => {
              :client_id => @id,
              :client_secret => @secret,
              :grant_type => 'client_credentials'
            }.to_json,
            :headers => {
              :content_type => :json,
              :accepts => :json
            },
            :ssl_version => 'SSLv23'
          )
        else
          access_token = RestClient::Request.execute(:method => :post, :url => "https://playlyfe.com/auth/token",
            :payload => {
              :client_id => @id,
              :client_secret => @secret,
              :grant_type => 'authorization_code',
              :code => @code,
              :redirect_uri => @redirect_uri
            }.to_json,
            :headers => {
              :content_type => :json,
              :accepts => :json
            },
            :ssl_version => 'SSLv23'
          )
        end
        access_token = JSON.parse(access_token)
        expires_at ||= Time.now.to_i + access_token['expires_in']
        access_token.delete('expires_in')
        access_token['expires_at'] = expires_at
        @store.call access_token
        if @load.nil?
          @load = lambda { return access_token }
        else
          old_token = @load.call
          if access_token != old_token
            @load = lambda { return access_token }
          end
        end
      rescue => e
        raise PlaylyfeClient::ConnectionError.new(e.response)
      end
    end

    def check_token(query)
      access_token = @load.call
      if access_token['expires_at'] < Time.now.to_i
        puts 'Access Token Expired'
        get_access_token()
        access_token = @load.call
      end
      query[:access_token] = access_token['access_token']
      query = hash_to_query(query)
    end

    def api(method, route, query = {}, body = {}, raw = false)
      query = check_token(query)
      begin
        uri="https://api.playlyfe.com/#{@version}#{route}?#{query}"
        puts "doing real query to api.uri : #{uri} with body #{body.to_json}" 
        response = RestClient::Request.execute(
          :method => method,
          :url => uri,
          :headers => {
            :content_type => :json,
            :accepts => :json
          },
          :payload => body.to_json,
          :ssl_version => 'SSLv23'
        )

        if raw == true
          return response.body
        else
          if response.body == 'null'
            return nil
          else
            return JSON.parse(response.body)
          end
        end
      rescue => e
        raise PlaylyfeClient::Error.build(e.response, "#{method} #{uri}")
      end
    end

    def get(route, query = {})
      api(:get, route, query, {}, false)
    end

    def get_raw(route, query = {})
      api(:get, route, query, {}, true)
    end

    def post(route, query = {}, body = {})
      api(:post, route, query, body, false)
    end

    def put(route, query = {}, body = {})
      api(:put, route, query, body, false)
    end

    def patch(route, query = {}, body = {})
      api(:patch, route, query, body, false)
    end

    def delete(route, query = {})
      api(:delete, route, query, {}, false)
    end

    def hash_to_query(hash)
      return URI.encode(hash.map{|k,v| "#{k}=#{v}"}.join("&"))
    end

    def get_login_url
      query = { response_type: 'code', redirect_uri: @redirect_uri, client_id: @id }
      "https://playlyfe.com/auth?#{hash_to_query(query)}"
    end

    def get_logout_url
      ""
    end

    def exchange_code(code)
      if code.nil?
        err = PlaylyfeClient::ConnectionError.new("")
        err.name = 'init_failed'
        err.message = 'You must pass in a code in exchange_code for the auth code flow'
        raise err
      else
        @code = code
        get_access_token()
      end
    end
  end

end
