module ExpectedResponses
  
  def full_players_hash
    {
      "data" => expected_player_hash_array, 
      "total" => 3 
    }
  end  

  def expected_player_hash_array
    [
      {
        "id" => "player1",
        "alias" => "player1_alias",
        "enabled" => true
      },
      {
        "id" => "player2",
        "alias" => "player2_alias",
        "enabled" => true
      },
      {
        "id" => "player3",
        "alias" => "player3_alias",
        "enabled" => true
      }
    ]  
  end  

  def full_game_hash
    {
      "name" => "Playlyfe Hermes",
      "version" => "v1",
      "status" => "ok",
      "game" => expected_game_hash
    }
  end  

  def expected_game_hash
    {
      "id" => "ruby_client_test",
      "title" => "Game for Ruby client test",
      "description" => "tests",
      "timezone" => "Europe/Prague",
      "type" => "native",
      "template" => "custom",
      "listed" => false,
      "access" => "PRIVATE",
      "image" => "default-game",
      "created" => "2016-04-26T14:23:27.408Z"
    }
  end

  def full_teams_hash
    {
      "data" => expected_team_hash_array,
      "total" => 3
    }
  end  

  def expected_team_hash_array
    [
      expected_team1_hash,
      {
        "id" => "team_57349f9b3409e252002cd0e3",
        "name" => "Team 2 baased on Team 1 template",
        "definition" => {
          "id" => "team1",
          "name" => "Team1"
        },
        "access" => "PRIVATE",
        "created" => "2016-05-12T15:22:03.976Z",
        "game_id" => "ruby_client_test",
        "owner" => {
          "id" => "player1",
          "alias" => "player1_alias"
        },
        "roles" => [
          "Captain",
          "Private"
        ]
      },
      {
        "id" => "team_57358d9d7d0ed66b01932e9a",
        "name" => "Player2Team",
        "definition" => {
          "id" => "team1",
          "name" => "Team1"
        },
        "access" => "PRIVATE",
        "created" => "2016-05-13T08:17:33.744Z",
        "game_id" => "ruby_client_test",
        "owner" => {
          "id" => "player2",
          "alias" => "player2_alias"
        },
        "roles" => [
          "Captain",
          "Private"
        ]
      }
    ]
  end

  def expected_team1_hash
    {
        "id" => "team_57349f7b7d0ed66b0193101f",
        "name" => "Team1 for RUby client",
        "definition" => {
          "id" => "team1",
          "name" => "Team1"
        },
        "access" => "PRIVATE",
        "created" => "2016-05-12T15:21:31.418Z",
        "game_id" => "ruby_client_test",
        "owner" => {
          "id" => "player1",
          "alias" => "player1_alias"
        },
        "roles" => [
          "Captain",
          "Private"
        ]
      }
  end  

  def expected_player1_profile_full_hash
    {
      "alias" => "player1_alias",
      "id" => "player1",
      "enabled" => true,
      "created" => "2016-05-04T11:39:26.539Z",
      "scores" => [
        {
          "metric" => {
            "id" => "plus_points",
            "name" => "plus_points",
            "type" => "point"
          },
          "value" => "2"
        },
        {
          "metric" => {
            "id" => "test_points",
            "name" => "test points",
            "type" => "point"
          },
          "value" => "7"
        }
      ],
      "teams" => [
        {
          "id" => "team_57349f9b3409e252002cd0e3",
          "definition" => {
            "id" => "team1",
            "name" => "Team1"
          },
          "roles" => [
            "Captain"
          ],
          "name" => "Team 2 baased on Team 1 template"
        },
        {
          "id" => "team_57349f7b7d0ed66b0193101f",
          "definition" => {
            "id" => "team1",
            "name" => "Team1"
          },
          "roles" => [
            "Captain"
          ],
          "name" => "Team1 for RUby client"
        }
      ]
    }
  end

end
