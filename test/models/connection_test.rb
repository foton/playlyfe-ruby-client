require_relative '../playlyfe_test_class.rb'

module Playlyfe

  class ConnectionTest < Playlyfe::Test
  
    def test_invalid_credentials
      begin
        Playlyfe::Connection.new(
          version: 'v2',
          client_id: "wrong_id",
          client_secret: "wrong_secret",
          type: 'client'
        )
      rescue Playlyfe::Error => e
        assert_equal e.name,'client_auth_fail'
        assert_equal e.message, 'Client authentication failed'
      end
    end

    def test_wrong_init #really I do not know what is this test for , I just took it from Ruby SDK
      begin
        Playlyfe::Connection.new(
          version: 'v2',
          client_id: CLIENT_ID,
          client_secret: CLIENT_SECRET
        )
      rescue Playlyfe::Error => e
        assert_equal e.name, 'init_failed'
      end
    end

    def test_wrong_route
      begin
        connection.get('/not_known_route', { player_id: 'student1' })
      rescue Playlyfe::Error => e
        assert_equal e.name,'route_not_found'
        assert e.message.include?('This route does not exist')
      end
    end  

    def test_return_api_version
       conn= Playlyfe::Connection.new(
        version: 'v2',
        client_id: CLIENT_ID,
        client_secret: CLIENT_SECRET,
        type: 'client'
      )

      assert_equal "v2", conn.api_version

      conn= Playlyfe::Connection.new(
        version: 'v1',
        client_id: CLIENT_ID,
        client_secret: CLIENT_SECRET,
        type: 'client'
      )

      assert_equal "v1", conn.api_version
    end  

    def test_get_game
      game= connection.game
      assert_equal "LMS", game.title
      assert_equal "Playlyfe Hermes", game.name
    end
    
    def test_raise_error_for_unknown_api_version
      #API V1 is implemented only in Connection, not other classes
      pl = Playlyfe::Connection.new( version: 'v1', client_id: CLIENT_ID, client_secret: CLIENT_SECRET, type: 'client')

      begin
        game=pl.game
      rescue Playlyfe::GameError => e
        
        assert_equal e.name, "unsupported version of API"
        assert_equal e.message, "'v1' of API is unsupported by playlyfe-ruby-client"
      end
    end
         


    #     players = pl.get('/players', { player_id: 'student1', limit: 1 })
    #     assert_not_nil players["data"]
    #     assert_not_nil players["data"][0]

    #     begin
    #       pl.get('/player')
    #     rescue Playlyfe::Error => e
    #       assert_equal e.message, "The 'player_id' parameter should be specified in the query"
    #     end

    #     player_id = 'student1'
    #     player = pl.get('/player', { player_id: player_id } )
    #     assert_equal player["id"], "student1"
    #     assert_equal player["alias"], "Student1"
    #     assert_equal player["enabled"], true

    #     pl.get('/definitions/processes', { player_id: player_id } )
    #     pl.get('/definitions/teams', { player_id: player_id } )
    #     pl.get('/processes', { player_id: player_id } )
    #     pl.get('/teams', { player_id: player_id } )

    #     processes = pl.get('/processes', { player_id: 'student1', limit: 1, skip: 4 })
    #     assert_equal processes["data"][0]["definition"], "module1"
    #     assert_equal processes["data"].size, 1

    #     new_process = pl.post('/definitions/processes/module1', { player_id: player_id })
    #     assert_equal new_process["definition"], "module1"
    #     assert_equal new_process["state"], "ACTIVE"

    #     patched_process = pl.patch(
    #       "/processes/#{new_process['id']}",
    #       { player_id: player_id },
    #       { name: 'patched_process', access: 'PUBLIC' }
    #     )

    #     assert_equal patched_process['name'], 'patched_process'
    #     assert_equal patched_process['access'], 'PUBLIC'

    #     deleted_process = pl.delete("/processes/#{new_process['id']}", { player_id: player_id })
    #     assert_not_nil deleted_process['message']

    #     raw_data = pl.get_raw('/player', { player_id: player_id })
    #     assert_equal raw_data.class, String
    #   end

    #   def my_test_init_staging_v2
    #     pl = Playlyfe::Connection.new(
    #       client_id: "Zjc0MWU0N2MtODkzNS00ZWNmLWEwNmYtY2M1MGMxNGQ1YmQ4",
    #       client_secret: "YzllYTE5NDQtNDMwMC00YTdkLWFiM2MtNTg0Y2ZkOThjYTZkMGIyNWVlNDAtNGJiMC0xMWU0LWI2NGEtYjlmMmFkYTdjOTI3",
    #       type: 'client'
    #     )

    #     begin
    #       pl.get('/gege', { player_id: 'student1' })
    #     rescue Playlyfe::Error => e
    #       assert_equal e.name,'route_not_found'
    #       assert_equal e.message, 'This route does not exist'
    #     end

    #     players = pl.api('GET', '/runtime/players', { player_id: 'student1', limit: 1 })
    #     assert_not_nil players["data"]
    #     assert_not_nil players["data"][0]

    #     players = pl.get('/runtime/players', { player_id: 'student1', limit: 1 })
    #     assert_not_nil players["data"]
    #     assert_not_nil players["data"][0]

    #     begin
    #       pl.get('/runtime/player')
    #     rescue Playlyfe::Error => e
    #       assert_equal e.message, "The 'player_id' parameter should be specified in the query"
    #     end

    #     player_id = 'student1'
    #     player = pl.get('/runtime/player', { player_id: player_id } )
    #     assert_equal player["id"], "student1"
    #     assert_equal player["alias"], "Student1"
    #     assert_equal player["enabled"], true

    #     pl.get('/runtime/definitions/processes', { player_id: player_id } )
    #     pl.get('/runtime/definitions/teams', { player_id: player_id } )
    #     pl.get('/runtime/processes', { player_id: player_id } )
    #     pl.get('/runtime/teams', { player_id: player_id } )

    #     processes = pl.get('/runtime/processes', { player_id: 'student1', limit: 1, skip: 4 })
    #     assert_equal processes["data"][0]["definition"], "module1"
    #     assert_equal processes["data"].size, 1

    #     new_process = pl.post('/runtime/processes', { player_id: player_id }, { definition: 'module1' })
    #     assert_equal new_process["definition"]["id"], "module1"
    #     assert_equal new_process["state"], "ACTIVE"

    #     patched_process = pl.patch(
    #       "/runtime/processes/#{new_process['id']}",
    #       { player_id: player_id },
    #       { name: 'patched_process', access: 'PUBLIC' }
    #     )

    #     assert_equal patched_process['name'], 'patched_process'
    #     assert_equal patched_process['access'], 'PUBLIC'

    #     deleted_process = pl.delete("/runtime/processes/#{new_process['id']}", { player_id: player_id })
    #     assert_not_nil deleted_process['message']

    #     #data = pl.put("/players/#{player_id}/reset", { player_id: player_id })
    #     #puts data

    #     raw_data = pl.get_raw('/runtime/player', { player_id: player_id })
    #     assert_equal raw_data.class, String

    #     new_metric = pl.post('/design/versions/latest/metrics', {}, {
    #       id: 'apple',
    #       name: 'apple',
    #       type: 'point',
    #       image: 'default-point-metric',
    #       description: '',
    #       constraints: {
    #         default: '0',
    #         max: 'Infinity',
    #         min: '0'
    #       }
    #     });
    #     assert_equal new_metric['id'], 'apple'
    #     deleted_metric = pl.delete('/design/versions/latest/metrics/apple')
    #     assert_equal deleted_metric['message'], "The metric 'apple' has been deleted successfully"
    #   end

    #   def my_test_init_production
    #     pl = Playlyfe::Connection.new(
    #       version: 'v1',
    #       client_id: "N2Y4NjNlYTItODQzZi00YTQ0LTkzZWEtYTBiNTA2ODg3MDU4",
    #       client_secret: "NDc3NTA0NmItMjBkZi00MjI2LWFhMjUtOTI0N2I1YTkxYjc2M2U3ZGI0MDAtNGQ1Mi0xMWU0LWJmZmUtMzkyZTdiOTYxYmMx",
    #       type: 'client'
    #     )
    #     pl.get('/game/players', { limit: 1 })
    #   end

    #   def my_test_store
    #     access_token = nil
    #     pl = Playlyfe::Connection.new(
    #       version: 'v1',
    #       client_id: "Zjc0MWU0N2MtODkzNS00ZWNmLWEwNmYtY2M1MGMxNGQ1YmQ4",
    #       client_secret: "YzllYTE5NDQtNDMwMC00YTdkLWFiM2MtNTg0Y2ZkOThjYTZkMGIyNWVlNDAtNGJiMC0xMWU0LWI2NGEtYjlmMmFkYTdjOTI3",
    #       type: 'client',
    #       store: lambda { |token| access_token = token },
    #       load: lambda { return access_token }
    #     )
    #     players = pl.get('/players', { player_id: 'student1', limit: 1 })
    #     assert_not_nil players["data"]
    #     assert_not_nil players["data"][0]
    #   end

    #   def my_test_auth_code_error
    #     begin
    #       Playlyfe::Connection.new(
    #         version: 'v1',
    #         client_id: "NGM2ZmYyNGQtNjViMy00YjQ0LWI0YTgtZTdmYWFlNDRkMmUx",
    #         client_secret: "ZTQ0OWI4YTItYzE4ZC00MWQ5LTg3YjktMDI5ZjAxYTBkZmRiZGQ0NzI4OTAtNGQ1My0xMWU0LWJmZmUtMzkyZTdiOTYxYmMx",
    #         type: 'code'
    #       )
    #     rescue Playlyfe::Error => e
    #       assert_equal e.name, 'init_failed'
    #     end
    #   end

    #   def my_test_auth_code
    #     Playlyfe::Connection.new(
    #       version: 'v1',
    #       client_id: "NGM2ZmYyNGQtNjViMy00YjQ0LWI0YTgtZTdmYWFlNDRkMmUx",
    #       client_secret: "ZTQ0OWI4YTItYzE4ZC00MWQ5LTg3YjktMDI5ZjAxYTBkZmRiZGQ0NzI4OTAtNGQ1My0xMWU0LWJmZmUtMzkyZTdiOTYxYmMx",
    #       type: 'code',
    #       redirect_uri: 'https://playlyfe.com/v1/api'
    #     )
    #   end

    #   def my_test_jwt
    #     token = Playlyfe.createJWT(
    #       client_id: "MWYwZGYzNTYtZGIxNy00OGM5LWExZGMtZjBjYTFiN2QxMTlh",
    #       client_secret: "NmM2YTcxOGYtNGE2ZC00ZDdhLTkyODQtYTIwZTE4ZDc5YWNjNWFiNzBiYjAtZmZiMC0xMWU0LTg5YzctYzc5NWNiNzA1Y2E4",
    #       player_id: 'student1',
    #       scopes: ['player.runtime.read'],
    #       expires: 30
    #     )
    #     puts token
    #   end
  
  end
end
