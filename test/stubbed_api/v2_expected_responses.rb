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
            "value" =>  "23"
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
                "count" =>  "1"
              },
              {
                "name" =>  "Screwdriver",
                "description" =>  "Just screwdriver",
                "count" =>  "2"
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
            "value" =>  "13"
          },
          {
            "metric" =>  {
              "id" =>  "test_points",
              "name" =>  "test points",
              "type" =>  "point"
            },
            "value" =>  "24"
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
            "score" =>  "16",
            "rank" =>  1
          },
          {
            "team" =>  {
              "id" =>  "team_57349f9b3409e252002cd0e3",
              "name" =>  "Team 2 baased on Team 1 template"
            },
            "score" =>  "13",
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
            "score" =>  "24",
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

    def self.full_all_actions_array
      [
        {
          "description" => "Just Action numero uno",
          "id" => "action1",
          "name" => "Action1 Name",
          "variables" => [],
          "rewards" => [
            {
              "metric" => {
                "id" => "test_points",
                "type" => "point",
                "name" => "test points"
              },
              "value" => "2",
              "verb" => "add",
              "probability" => 1
            }
          ],
          "count" => 10
        },
        {
          "description" => "Action 2 is the second action to play. Adds plus_points and test_points.",
          "id" => "action2",
          "name" => "Action2 Name",
          "variables" => [],
          "rewards" => [
            {
              "metric" => {
                "id" => "plus_points",
                "type" => "point",
                "name" => "plus_points"
              },
              "value" => "1",
              "verb" => "add",
              "probability" => 1
            },
            {
              "metric" => {
                "id" => "test_points",
                "type" => "point",
                "name" => "test points"
              },
              "value" => "1",
              "verb" => "add",
              "probability" => 1
            }
          ],
          "count" => 2
        },
        {
          "id" => "get_hammer",
          "name" => "get_hammer",
          "variables" => [],
          "rewards" => [
            {
              "metric" => {
                "id" => "toolbox",
                "type" => "set",
                "name" => "Toolbox"
              },
              "value" => {
                "Hammer" => "1"
              },
              "verb" => "add",
              "probability" => 1
            }
          ],
          "count" => 1
        },
        get_hammer_screwdriver_and_plus_point_action_hash,
        {
          "description" => "For reverting action \"get_hammer_screwdriver_and_plus_point\".",
          "id" => "loose_hammer_screwdriver_and_plus_point",
          "name" => "loose_hammer_screwdriver_and_plus_point",
          "variables" => [],
          "rewards" => [
            {
              "metric" => {
                "id" => "toolbox",
                "type" => "set",
                "name" => "Toolbox"
              },
              "value" => {
                "Hammer" => "1"
              },
              "verb" => "remove",
              "probability" => 1
            },
            {
              "metric" => {
                "id" => "toolbox",
                "type" => "set",
                "name" => "Toolbox"
              },
              "value" => {
                "Screwdriver" => "1"
              },
              "verb" => "remove",
              "probability" => 1
            },
            {
              "metric" => {
                "id" => "plus_points",
                "type" => "point",
                "name" => "plus_points"
              },
              "value" => "1",
              "verb" => "remove",
              "probability" => 1
            }
          ],
          "count" => 0
        },
        {
          "description" => "add 1 plus_point",
          "id" => "plus_action",
          "name" => "Plus action",
          "variables" => [],
          "rewards" => [
            {
              "metric" => {
                "id" => "plus_points",
                "type" => "point",
                "name" => "plus_points"
              },
              "value" => "1",
              "verb" => "add",
              "probability" => 1
            }
          ],
          "count" => 1
        }
      ]
    end  

    def self.get_hammer_screwdriver_and_plus_point_action_hash
        {
          "id" => "get_hammer_screwdriver_and_plus_point",
          "name" => "get_hammer_screwdriver_and_plus_point",
          "variables" => [],
          "rewards" => [
            {
              "metric" => {
                "id" => "toolbox",
                "type" => "set",
                "name" => "Toolbox"
              },
              "value" => {
                "Hammer" => "1"
              },
              "verb" => "add",
              "probability" => 1
            },
            {
              "metric" => {
                "id" => "plus_points",
                "type" => "point",
                "name" => "plus_points"
              },
              "value" => "1",
              "verb" => "add",
              "probability" => 1
            },
            {
              "metric" => {
                "id" => "toolbox",
                "type" => "set",
                "name" => "Toolbox"
              },
              "value" => {
                "Screwdriver" => "1"
              },
              "verb" => "add",
              "probability" => 1
            }
          ],
          "count" => 2
        }
      end


      def self.full_metrics_array
        [
          compound_metric_hash,
          state_metric_hash,
          point_metric_hash1,
          point_metric_hash2,
          set_metric_hash
        ]
      end  
          
      def self.compound_metric_hash
        {
          "description" => "Just mixed metric with no purpose",
          "formula" => " $scores['test_points'] -$scores['toolbox']['multitool'] ",
          "id" => "compound_metric",
          "name" => "Compound metric",
          "type" => "compound"
        }
      end

      def self.state_metric_hash
      {
        "description" => "How many experiences player have",
        "id" => "experience",
        "name" => "Experience",
        "states" => {
          "Apprentice" => {
            "description" => ""
          },
          "Guild leader" => {
            "description" => ""
          },
          "Journeyman" => {
            "description" => ""
          },
          "Master" => {
            "description" => ""
          }
        },
        "type" => "state"
      }
      end
           
      def self.point_metric_hash1
        {
          "description" => "This metrics measure nothing.",
          "id" => "plus_points",
          "name" => "plus_points",
          "type" => "point"
        }
      end

      def self.point_metric_hash2
        {
          "id" => "test_points",
          "name" => "test points",
          "type" => "point"
        }
      end

      def self.set_metric_hash
        {
          "id" => "toolbox",
          "items" => {
            "Hammer" => {
              "description" => "Hammer for nails"
            },
            "Multitool" => {
              "description" => "Universal do-all-thing tool. Very rare!"
            },
            "Screwdriver" => {
              "description" => "Just screwdriver"
            }
          },
          "name" => "Toolbox",
          "type" => "set"
        }
      end                                                             

      def self.full_play_action_hammer_screwdriver_and_plus_point_hash
        {
          "actions" => [
            {
              "description" => "Just Action numero uno",
              "id" => "action1",
              "name" => "Action1 Name",
              "variables" => [],
              "rewards" => [
                {
                  "metric" => {
                    "id" => "test_points",
                    "type" => "point",
                    "name" => "test points"
                  },
                  "value" => "2",
                  "verb" => "add",
                  "probability" => 1
                }
              ],
              "count" => 10
            },
            {
              "description" => "Action 2 is the second action to play. Adds plus_points and test_points.",
              "id" => "action2",
              "name" => "Action2 Name",
              "variables" => [],
              "rewards" => [
                {
                  "metric" => {
                    "id" => "plus_points",
                    "type" => "point",
                    "name" => "plus_points"
                  },
                  "value" => "1",
                  "verb" => "add",
                  "probability" => 1
                },
                {
                  "metric" => {
                    "id" => "test_points",
                    "type" => "point",
                    "name" => "test points"
                  },
                  "value" => "1",
                  "verb" => "add",
                  "probability" => 1
                }
              ],
              "count" => 2
            },
            {
              "id" => "get_hammer",
              "name" => "get_hammer",
              "variables" => [],
              "rewards" => [
                {
                  "metric" => {
                    "id" => "toolbox",
                    "type" => "set",
                    "name" => "Toolbox"
                  },
                  "value" => {
                    "Hammer" => "1"
                  },
                  "verb" => "add",
                  "probability" => 1
                }
              ],
              "count" => 1
            },
            {
              "id" => "get_hammer_screwdriver_and_plus_point",
              "name" => "get_hammer_screwdriver_and_plus_point",
              "variables" => [],
              "rewards" => [
                {
                  "metric" => {
                    "id" => "toolbox",
                    "type" => "set",
                    "name" => "Toolbox"
                  },
                  "value" => {
                    "Hammer" => "1"
                  },
                  "verb" => "add",
                  "probability" => 1
                },
                {
                  "metric" => {
                    "id" => "plus_points",
                    "type" => "point",
                    "name" => "plus_points"
                  },
                  "value" => "1",
                  "verb" => "add",
                  "probability" => 1
                },
                {
                  "metric" => {
                    "id" => "toolbox",
                    "type" => "set",
                    "name" => "Toolbox"
                  },
                  "value" => {
                    "Screwdriver" => "1"
                  },
                  "verb" => "add",
                  "probability" => 1
                }
              ],
              "count" => 2
            },
            {
              "description" => "For reverting action \"get_hammer_screwdriver_and_plus_point\".",
              "id" => "loose_hammer_screwdriver_and_plus_point",
              "name" => "loose_hammer_screwdriver_and_plus_point",
              "variables" => [],
              "rewards" => [
                {
                  "metric" => {
                    "id" => "toolbox",
                    "type" => "set",
                    "name" => "Toolbox"
                  },
                  "value" => {
                    "Hammer" => "1"
                  },
                  "verb" => "remove",
                  "probability" => 1
                },
                {
                  "metric" => {
                    "id" => "toolbox",
                    "type" => "set",
                    "name" => "Toolbox"
                  },
                  "value" => {
                    "Screwdriver" => "1"
                  },
                  "verb" => "remove",
                  "probability" => 1
                },
                {
                  "metric" => {
                    "id" => "plus_points",
                    "type" => "point",
                    "name" => "plus_points"
                  },
                  "value" => "1",
                  "verb" => "remove",
                  "probability" => 1
                }
              ],
              "count" => 0
            },
            {
              "description" => "add 1 plus_point",
              "id" => "plus_action",
              "name" => "Plus action",
              "variables" => [],
              "rewards" => [
                {
                  "metric" => {
                    "id" => "plus_points",
                    "type" => "point",
                    "name" => "plus_points"
                  },
                  "value" => "1",
                  "verb" => "add",
                  "probability" => 1
                }
              ],
              "count" => 1
            }
          ],
          "events" => {
            "local" => [
              {
                "event" => "action",
                "actor" => {
                  "id" => "player1",
                  "alias" => "player1_alias"
                },
                "action" => {
                  "id" => "get_hammer_screwdriver_and_plus_point",
                  "name" => "get_hammer_screwdriver_and_plus_point",
                  "vars" => {}
                },
                "count" => 1,
                "changes" => [
                  {
                    "metric" => {
                      "id" => "toolbox",
                      "name" => "Toolbox",
                      "type" => "set"
                    },
                    "delta" => {
                      "Hammer" => {
                        "old" => "1",
                        "new" => "2"
                      }
                    }
                  },
                  {
                    "metric" => {
                      "id" => "plus_points",
                      "name" => "plus_points",
                      "type" => "point"
                    },
                    "delta" => {
                      "old" => "13",
                      "new" => "14"
                    }
                  },
                  {
                    "metric" => {
                      "id" => "toolbox",
                      "name" => "Toolbox",
                      "type" => "set"
                    },
                    "delta" => {
                      "Screwdriver" => {
                        "old" => "2",
                        "new" => "3"
                      }
                    }
                  }
                ],
                "timestamp" => "2016-05-19T09:59:11.179Z",
                "scopes" => [],
                "id" => "55c0d1b0-1da8-11e6-9d43-49dbe52b2558"
              }
            ],
            "global" => []
          }
        }
      end  

    end  
  end
end
