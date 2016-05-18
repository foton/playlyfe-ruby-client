module Playlyfe
  module Testing
#    module V2
    class ExpectedResponses
    
    def self.full_players_hash
      {
        "data" => player_hash_array, 
        "total" => 3 
      }
    end  

    def self.player_hash_array
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

    def self.full_game_hash
      {
        "name" => "Playlyfe Hermes",
        "version" => "v1",
        "status" => "ok",
        "game" => game_hash
      }
    end  

    def self.game_hash
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

    def self.full_teams_hash
      {
        "data" => team_hash_array,
        "total" => 3
      }
    end  

    def self.team_hash_array
      [
        team1_hash,
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
            "Private",
            "Sergeant",
            "Captain"
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
            "Private",
            "Sergeant",
            "Captain"
          ]
        }
      ]
    end

    def self.team1_hash
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
            "Private",
            "Sergeant",
            "Captain"
          ]
        }
    end  

    def self.full_profile_hash_for_player1
      {
        "alias" =>  "player1_alias",
        "id" =>  "player1",
        "enabled" =>  true,
        "created" =>  "2016-05-04T11:39:26.539Z",
        "scores" =>  [
          {
            "metric" =>  {
              "id" =>  "compound_metric",
              "name" =>  "Compound metric",
              "type" =>  "compound"
            },
            "value" =>  "21"
          },
          {
            "metric" =>  {
              "id" =>  "experience",
              "name" =>  "Experience",
              "type" =>  "state"
            },
            "value" =>  {
              "name" =>  "Guild leader",
              "description" =>  ""
            },
            "meta" =>  {
              "high" =>  "Infinity",
              "low" =>  "21",
              "base_metric" =>  {
                "id" =>  "test_points",
                "name" =>  "test points"
              }
            }
          },
          {
            "metric" =>  {
              "id" =>  "toolbox",
              "name" =>  "Toolbox",
              "type" =>  "set"
            },
            "value" =>  [
              {
                "name" =>  "Hammer",
                "description" =>  "Hammer for nails",
                "count" =>  "2"
              },
              {
                "name" =>  "Screwdriver",
                "description" =>  "Just screwdriver",
                "count" =>  "1"
              },
              {
                "name" =>  "Multitool",
                "description" =>  "Universal do-all-thing tool. Very rare!",
                "count" =>  "1"
              }
            ]
          },
          {
            "metric" =>  {
              "id" =>  "plus_points",
              "name" =>  "plus_points",
              "type" =>  "point"
            },
            "value" =>  "4"
          },
          {
            "metric" =>  {
              "id" =>  "test_points",
              "name" =>  "test points",
              "type" =>  "point"
            },
            "value" =>  "22"
          }
        ],
        "teams" =>  [
          {
            "id" =>  "team_57349f9b3409e252002cd0e3",
            "definition" =>  {
              "id" =>  "team1",
              "name" =>  "Team1"
            },
            "roles" =>  [
              "Captain"
            ],
            "name" =>  "Team 2 baased on Team 1 template"
          },
          {
            "id" =>  "team_57349f7b7d0ed66b0193101f",
            "definition" =>  {
              "id" =>  "team1",
              "name" =>  "Team1"
            },
            "roles" =>  [
              "Captain",
              "Private"
            ],
            "name" =>  "Team1 for RUby client"
          }
        ]
      }
    end


    def self.full_team1_members_hash
      {
        "data" => team1_members_hash_array,
        "total" => 3
      }
    end  

    def self.team1_members_hash_array
      [
        {
          "id" =>  "player1",
          "alias" =>  "player1_alias"
        },
        {
          "id" =>  "player2",
          "alias" =>  "player2_alias"
        },
        {
          "id" =>  "player3",
          "alias" =>  "player3_alias"
        }
      ]
    end  


    def self.full_leaderboards_array
      [
        {
          "cycles" =>  [
            "alltime"
          ],
          "entity_type" =>  "players",
          "id" =>  "leaderboard1",
          "metric" =>  {
            "id" =>  "test_points",
            "type" =>  "point",
            "name" =>  "test points"
          },
          "name" =>  "Leaderboard Test points Name",
          "scope" =>  {
            "type" =>  "game"
          }
        },
        {
          "cycles" =>  [
            "alltime"
          ],
          "entity_type" =>  "teams",
          "id" =>  "leaderboard_plus_points",
          "metric" =>  {
            "id" =>  "plus_points",
            "type" =>  "point",
            "name" =>  "plus_points"
          },
          "name" =>  "Leaderboard plus points",
          "scope" =>  {
            "type" =>  "game"
          }
        }
      ]
    end

    def self.full_teams_leaderboard_hash #leaderboard_plus_points
      {
        "data" =>  [
          {
            "team" =>  {
              "id" =>  "team_57349f7b7d0ed66b0193101f",
              "name" =>  "Team1 for RUby client"
            },
            "score" =>  "7",
            "rank" =>  1
          },
          {
            "team" =>  {
              "id" =>  "team_57349f9b3409e252002cd0e3",
              "name" =>  "Team 2 baased on Team 1 template"
            },
            "score" =>  "4",
            "rank" =>  2
          },
          {
            "team" =>  {
              "id" =>  "team_57358d9d7d0ed66b01932e9a",
              "name" =>  "Player2Team"
            },
            "score" =>  "0",
            "rank" =>  3
          }
        ],
        "total" =>  3
      }
    end

    def self.full_players_leaderboard_hash #leaderboard1
      {
        "data" =>  [
          {
            "player" =>  {
              "alias" =>  "player1_alias",
              "id" =>  "player1"
            },
            "score" =>  "22",
            "rank" =>  1
          },
          {
            "player" =>  {
              "alias" =>  "player2_alias",
              "id" =>  "player2"
            },
            "score" =>  "5",
            "rank" =>  2
          },
          {
            "player" =>  {
              "alias" =>  "player3_alias",
              "id" =>  "player3"
            },
            "score" =>  "4",
            "rank" =>  3
          }
        ],
        "total" =>  3
      }
    end  

    end  
  end
end
