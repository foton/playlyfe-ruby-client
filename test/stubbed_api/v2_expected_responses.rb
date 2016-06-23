module PlaylyfeClient
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
              }.freeze,
              "value" =>  "23"
            }.freeze,
            {
              "metric" =>  {
                "id" =>  "experience",
                "name" =>  "Experience",
                "type" =>  "state"
              }.freeze,
              "value" =>  {
                "name" =>  "Guild leader",
                "description" =>  ""
              }.freeze,
              "meta" =>  {
                "high" =>  "Infinity",
                "low" =>  "21",
                "base_metric" =>  {
                  "id" =>  "test_points",
                  "name" =>  "test points"
                }.freeze
              }.freeze
            }.freeze,
            {
              "metric" =>  {
                "id" =>  "toolbox",
                "name" =>  "Toolbox",
                "type" =>  "set"
              }.freeze,
              "value" =>  [
                   {
                  "name" =>  "Multitool",
                  "description" =>  "Universal do-all-thing tool. Very rare!",
                  "count" =>  "1"
                }.freeze,
                {
                  "name" =>  "Hammer",
                  "description" =>  "Hammer for nails",
                  "count" =>  "1" #DO NOT CHANGE this value unless test for "PLAY ACTION" is successfull. Then call "loose_hammer ...." action to decrease real values to test values.
                }.freeze,
                {
                  "name" =>  "Screwdriver",
                  "description" =>  "Just screwdriver",
                  "count" =>  "1"
                }.freeze,
              ].freeze
            }.freeze,
            {
              "metric" =>  {
                "id" =>  "plus_points",
                "name" =>  "plus_points",
                "type" =>  "point"
              }.freeze,
              "value" =>  "19"
            }.freeze,
            {
              "metric" =>  {
                "id" =>  "test_points",
                "name" =>  "test points",
                "type" =>  "point"
              }.freeze,
              "value" =>  "24"
            }.freeze
          ].freeze,
          "teams" =>  [
            {
              "id" =>  "team_57349f9b3409e252002cd0e3",
              "definition" =>  {
                "id" =>  "team1",
                "name" =>  "Team1"
              }.freeze,
              "roles" =>  [
                "Captain"
              ].freeze,
              "name" =>  "Team 2 baased on Team 1 template"
            }.freeze,
            {
              "id" =>  "team_57349f7b7d0ed66b0193101f",
              "definition" =>  {
                "id" =>  "team1",
                "name" =>  "Team1"
              }.freeze,
              "roles" =>  [
                "Captain",
                "Private"
              ].freeze,
              "name" =>  "Team1 for RUby client"
            }.freeze
          ].freeze
        }.freeze
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
              "score" =>  "24",
              "rank" =>  1
            },
            {
              "team" =>  {
                "id" =>  "team_57349f9b3409e252002cd0e3",
                "name" =>  "Team 2 baased on Team 1 template"
              },
              "score" =>  "19",
              "rank" =>  2
            },
            {
              "team" =>  {
                "id" =>  "team_57358d9d7d0ed66b01932e9a",
                "name" =>  "Player2Team"
              },
              "score" =>  "2",
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
              "score" =>  "6",
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
            "count" => 2
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
            "count" => 57
          },
          one_time_per_day_action_hash,
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
          },
          set_test_points_to_value_action_hash
        ]
      end  

      def self.one_time_per_day_action_hash
        {
          "id" => "only_one_time_per_day_action",
          "name" => "only one time per day action",
          "variables" => [],
          "rewards" =>[
            {"metric" => {"id" => "test_points", "type" => "point", "name" => "test points"}, "value" => "1", "verb" => "add", "probability" => 1}
          ],
          "count" => 1}
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
            "count" => 75
          }
      end

      def self.set_test_points_to_value_action_hash
        {
          "id" => "set_test_points_to_value",
          "name" => "set_test_points_to_value",
          "variables" => [
            {
              "default" => 0,
              "name" => "tst_p",
              "required" => true,
              "type" => "int"
            }
          ],
          "rewards" => [
            {
              "metric" => {
                "id" => "test_points",
                "type" => "point",
                "name" => "test points"
              },
              "value" => "$vars['tst_p'] ",
              "verb" => "set",
              "probability" => 1
            }
          ],
          "count" => 6
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
          "actions" => full_all_actions_array,
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
                      "old" => "19",
                      "new" => "20"
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
                        "old" => "1",
                        "new" => "2"
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

      def self.full_error_for_playing_action_over_limit
        PlaylyfeClient::ActionRateLimitExceededError.new("{\"error\": \"rate_limit_exceeded\", \"error_description\": \"The Action 'only_one_time_per_day_action' can only be triggered 1 times every day\"}", "post https://api.playlyfe.com/v2/runtime/actions/only_one_time_per_day_action/play?player_id=player1&access_token=NDgwNTQ4ZDYtYjkzNC00N2M3LTkyMDYtN2M0N2MzMGYyOTY3")
      end  

      def self.full_player2_activity_feed_array(start_time=nil, end_time=nil)
        #response for /admin/players/player2/activity?start=2016-05-01T00:00:00Z&end=2016-05-21T00:00:00Z
        response_2016_may_01_to_20 = [
            {
              "event" => "action",
              "action" => {
                "id" => "action1",
                "name" => "Action1 Name",
                "vars" => {}
              },
              "count" => 1,
              "changes" => [
                {
                  "metric" => {
                    "id" => "test_points",
                    "name" => "test points",
                    "type" => "point"
                  },
                  "delta" => {
                    "old" => nil,
                    "new" => "4"
                  }
                }
              ],
              "timestamp" => "2016-05-04T11:46:13.080Z",
              "scopes" => [],
              "id" => "cd4ee580-11ed-11e6-abea-5b76dd840df5"
            },
            {
              "event" => "action",
              "action" => {
                "id" => "action2",
                "name" => "Action2 Name",
                "vars" => {}
              },
              "count" => 1,
              "changes" => [
                {
                  "metric" => {
                    "id" => "plus_points",
                    "name" => "plus_points",
                    "type" => "point"
                  },
                  "delta" => {
                    "old" => nil,
                    "new" => "1"
                  }
                },
                {
                  "metric" => {
                    "id" => "test_points",
                    "name" => "test points",
                    "type" => "point"
                  },
                  "delta" => {
                    "old" => "4",
                    "new" => "5"
                  }
                }
              ],
              "timestamp" => "2016-05-13T08:16:41.623Z",
              "scopes" => [],
              "id" => "05da8a70-18e3-11e6-994a-cdc1f8270ce4"
            },
            {
              "event" => "create",
              "timestamp" => "2016-05-13T08:17:33.744Z",
              "team" => {
                "id" => "team_57358d9d7d0ed66b01932e9a",
                "name" => "Player2Team"
              },
              "id" => "24eb9301-18e3-11e6-bb4b-c56c5e56f0bf"
            },
            {
              "event" => "invite:accept",
              "timestamp" => "2016-05-17T09:59:53.381Z",
              "inviter" => {
                "id" => "player1",
                "alias" => "player1_alias"
              },
              "team" => {
                "id" => "team_57349f7b7d0ed66b0193101f",
                "name" => "Team1 for RUby client"
              },
              "roles" => {
                "Private" => true
              },
              "id" => "1a14d551-1c16-11e6-bb4b-c56c5e56f0bf"
            },
            {
              "event" => "action",
              "action" => {
                "id" => "action2",
                "name" => "Action2 Name",
                "vars" => {}
              },
              "count" => 1,
              "changes" => [
                {
                  "metric" => {
                    "id" => "plus_points",
                    "name" => "plus_points",
                    "type" => "point"
                  },
                  "delta" => {
                    "old" => "1",
                    "new" => "2"
                  }
                },
                {
                  "metric" => {
                    "id" => "test_points",
                    "name" => "test points",
                    "type" => "point"
                  },
                  "delta" => {
                    "old" => "5",
                    "new" => "6"
                  }
                },
                {
                  "metric" => {
                    "id" => "compound_metric",
                    "name" => "Compound metric",
                    "type" => "compound"
                  },
                  "delta" => {
                    "old" => "5",
                    "new" => "6"
                  }
                }
              ],
              "timestamp" => "2016-05-20T13:20:13.079Z",
              "scopes" => [],
              "id" => "959e7270-1e8d-11e6-9d43-49dbe52b2558"
            },
            {
              "event" => "level",
              "changes" => [
                {
                  "metric" => {
                    "id" => "experience",
                    "name" => "Experience",
                    "type" => "state"
                  },
                  "delta" => {
                    "old" => nil,
                    "new" => "Journeyman"
                  }
                }
              ],
              "rule" => {
                "id" => "leveling_in_experience"
              },
              "timestamp" => "2016-05-20T13:20:13.079Z",
              "id" => "959e7271-1e8d-11e6-9d43-49dbe52b2558"
            },
            {
              "event" => "action",
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
                      "old" => nil,
                      "new" => "1"
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
                    "old" => "2",
                    "new" => "3"
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
                      "old" => nil,
                      "new" => "1"
                    }
                  }
                }
              ],
              "timestamp" => "2016-05-20T13:20:22.222Z",
              "scopes" => [],
              "id" => "9b118ee0-1e8d-11e6-9d43-49dbe52b2558"
            }
          ]

        activities=response_2016_may_01_to_20  

        if start_time
          activities=activities.select {|act| act["timestamp"] > start_time.utc.strftime("%Y-%m-%dT%H:%M:%S.%LZ") }
        end    

        if end_time
          activities=activities.select {|act| act["timestamp"] < end_time.utc.strftime("%Y-%m-%dT%H:%M:%S.%LZ") }
        end    
        activities 
      end

      def self.player_created_hash(pl_h)
        {
          "id" => pl_h[:id],
          "alias" => pl_h[:alias],
          "created" => Time.now.utc.strftime("%Y-%m-%dT%H:%M:%S.%LZ"),
          "scores" => {},
          "teams" => {},
          "enabled" => true,
          "bootstrap" => true
        }
      end

      def self.full_error_for_creating_existing_player(player_id)
        PlaylyfeClient::PlayerExistsError.new("{\"error\": \"player_exists\", \"error_description\": \"A player with ID '#{player_id}' already exists\"}", "post https://api.playlyfe.com/v2/admin/players?&access_token=NDgwNTQ4ZDYtYjkzNC00N2M3LTkyMDYtN2M0N2MzMGYyOTY3")
      end 

      def self.game_events_array
        #response for /admin/activity?start=2016-05-01T00:00:00Z&end=2016-05-21T00:00:00Z
        [
          team_create_event_hash,
          {
            "event" => "create",
            "timestamp" => "2016-05-12T15:22:03.976Z",
            "team" => {
              "id" => "team_57349f9b3409e252002cd0e3",
              "name" => "Team 2 baased on Team 1 template"
            },
            "actor" => {
              "id" => "player1",
              "alias" => "player1_alias"
            },
            "id" => "47f2cc80-1855-11e6-8343-47b85380947e"
          },
          {
            "event" => "create",
            "timestamp" => "2016-05-13T08:17:33.744Z",
            "team" => {
              "id" => "team_57358d9d7d0ed66b01932e9a",
              "name" => "Player2Team"
            },
            "actor" => {
              "id" => "player2",
              "alias" => "player2_alias"
            },
            "id" => "24eb9301-18e3-11e6-bb4b-c56c5e56f0bf"
          },
          {
            "event" => "level",
            "actor" => {
              "id" => "player1",
              "alias" => "player1_alias"
            },
            "changes" => [
              {
                "metric" => {
                  "id" => "experience",
                  "name" => "Experience",
                  "type" => "state"
                },
                "delta" => {
                  "old" => nil,
                  "new" => "Journeyman"
                }
              }
            ],
            "rule" => {
              "id" => "leveling_in_experience"
            },
            "timestamp" => "2016-05-17T09:52:12.209Z",
            "id" => "07339211-1c15-11e6-994a-cdc1f8270ce4"
          },
          level_up_event_hash,
          {
            "event" => "level",
            "actor" => {
              "id" => "player1",
              "alias" => "player1_alias"
            },
            "changes" => [
              {
                "metric" => {
                  "id" => "experience",
                  "name" => "Experience",
                  "type" => "state"
                },
                "delta" => {
                  "old" => "Master",
                  "new" => "Guild leader"
                }
              }
            ],
            "rule" => {
              "id" => "leveling_in_experience"
            },
            "timestamp" => "2016-05-17T09:53:04.387Z",
            "id" => "264d4d31-1c15-11e6-994a-cdc1f8270ce4"
          },
          achievement_event_hash,
          {
            "event" => "level",
            "actor" => {
              "id" => "player3",
              "alias" => "player3_alias"
            },
            "changes" => [
              {
                "metric" => {
                  "id" => "experience",
                  "name" => "Experience",
                  "type" => "state"
                },
                "delta" => {
                  "old" => nil,
                  "new" => "Apprentice"
                }
              }
            ],
            "rule" => {
              "id" => "leveling_in_experience"
            },
            "timestamp" => "2016-05-17T10:00:14.824Z",
            "id" => "26dcc681-1c16-11e6-994a-cdc1f8270ce4"
          },
          {
            "event" => "level",
            "actor" => {
              "id" => "player3",
              "alias" => "player3_alias"
            },
            "changes" => [
              {
                "metric" => {
                  "id" => "experience",
                  "name" => "Experience",
                  "type" => "state"
                },
                "delta" => {
                  "old" => "Apprentice",
                  "new" => "Journeyman"
                }
              }
            ],
            "rule" => {
              "id" => "leveling_in_experience"
            },
            "timestamp" => "2016-05-17T10:00:18.049Z",
            "id" => "28c8df11-1c16-11e6-abea-5b76dd840df5"
          },
          {
            "event" => "level",
            "actor" => {
              "id" => "player2",
              "alias" => "player2_alias"
            },
            "changes" => [
              {
                "metric" => {
                  "id" => "experience",
                  "name" => "Experience",
                  "type" => "state"
                },
                "delta" => {
                  "old" => nil,
                  "new" => "Journeyman"
                }
              }
            ],
            "rule" => {
              "id" => "leveling_in_experience"
            },
            "timestamp" => "2016-05-20T13:20:13.079Z",
            "id" => "959e7271-1e8d-11e6-9d43-49dbe52b2558"
          }
        ]
      end  

      def self.team_create_event_hash
        {
          "event" => "create",
          "timestamp" => "2016-05-12T15:21:31.418Z",
          "team" => {
            "id" => "team_57349f7b7d0ed66b0193101f",
            "name" => "Team1 for RUby client"
          },
          "actor" => {
            "id" => "player1",
            "alias" => "player1_alias"
          },
          "id" => "348ad7a1-1855-11e6-bb4a-c56c5e56f0bf"
        }
      end

      def self.level_up_event_hash  
        {
          "event" => "level",
          "actor" => {
            "id" => "player1",
            "alias" => "player1_alias"
          },
          "changes" => [
            {
              "metric" => {
                "id" => "experience",
                "name" => "Experience",
                "type" => "state"
              },
              "delta" => {
                "old" => "Journeyman",
                "new" => "Master"
              }
            }
          ],
          "rule" => {
            "id" => "leveling_in_experience"
          },
          "timestamp" => "2016-05-17T09:52:45.582Z",
          "id" => "1b17e2e1-1c15-11e6-abea-5b76dd840df5"
        }
      end  

      def self.achievement_event_hash
        {
          "event" => "achievement",
          "actor" => {
            "id" => "player1",
            "alias" => "player1_alias"
          },
          "changes" => [
            {
              "metric" => {
                "id" => "toolbox",
                "name" => "Toolbox",
                "type" => "set"
              },
              "delta" => {
                "Multitool" => {
                  "old" => nil,
                  "new" => "1"
                }
              }
            },
            {
              "metric" => {
                "id" => "compound_metric",
                "name" => "Compound metric",
                "type" => "compound"
              },
              "delta" => {
                "old" => "22",
                "new" => "21"
              }
            }
          ],
          "rule" => {
            "id" => "get_a_multitool"
          },
          "timestamp" => "2016-05-17T09:53:04.387Z",
          "id" => "264d4d32-1c15-11e6-994a-cdc1f8270ce4"
        }
      end

    end  #end of class
  end
end
