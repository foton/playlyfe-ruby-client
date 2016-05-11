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
end
