require_relative '../playlyfe_test_class.rb'

module PlaylyfeClient

  class ConnectionTest < PlaylyfeClient::Test
  
    def test_invalid_credentials
      begin
        PlaylyfeClient::Connection.new(
          version: 'v2',
          client_id: "wrong_id",
          client_secret: "wrong_secret",
          type: 'client'
        )
      rescue PlaylyfeClient::Error => e
        assert_equal e.name,'client_auth_fail'
        assert_equal e.message, 'Client authentication failed'
      end
    end

    def test_wrong_init #really I do not know what is this test for , I just took it from Ruby SDK
      begin
        PlaylyfeClient::Connection.new(
          version: 'v2',
          client_id: CLIENT_ID,
          client_secret: CLIENT_SECRET
        )
      rescue PlaylyfeClient::Error => e
        assert_equal e.name, 'init_failed'
      end
    end

    def test_wrong_route
      begin
        connection.get('/not_known_route', { player_id: 'student1' })
      rescue PlaylyfeClient::Error => e
        assert_equal e.name,'route_not_found'
        assert e.message.include?('This route does not exist')
      end
    end  

    def test_return_api_version
       conn= PlaylyfeClient::Connection.new(
        version: 'v2',
        client_id: CLIENT_ID,
        client_secret: CLIENT_SECRET,
        type: 'client'
      )

      assert_equal "v2", conn.api_version

      conn= PlaylyfeClient::Connection.new(
        version: 'v1',
        client_id: CLIENT_ID,
        client_secret: CLIENT_SECRET,
        type: 'client'
      )

      assert_equal "v1", conn.api_version
    end  

    def test_get_game
      game= connection.game
      assert_equal "Game for Ruby client test", game.title
    end
        
    def test_raise_error_for_unknown_api_version
      #API V1 is implemented only in Connection, not other classes
      pl = PlaylyfeClient::Connection.new( version: 'v1', client_id: CLIENT_ID, client_secret: CLIENT_SECRET, type: 'client')

      begin
        game=pl.game
      rescue PlaylyfeClient::GameError => e
        
        assert_equal e.name, "unsupported version of API"
        assert_equal e.message, "'v1' of API is unsupported by playlyfe-client"
      end
    end
        
  end
end
