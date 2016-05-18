module StubbedQuerries
  
  def stub_game_query(stubbed_response=Playlyfe::Testing::ExpectedResponses.full_game_hash, &block)
    connection.stub :get_full_game_hash, stubbed_response do 
      yield 
    end
  end  

  def stub_players_query(stubbed_response=Playlyfe::Testing::ExpectedResponses.full_players_hash, &block)
    connection.stub :get_full_players_hash, stubbed_response do 
      yield 
    end
  end  

  def stub_teams_query(stubbed_response=Playlyfe::Testing::ExpectedResponses.full_teams_hash, &block)
    connection.stub :get_full_teams_hash, stubbed_response do 
      yield 
    end
  end 

  def stub_player_profile_query(stubbed_response=Playlyfe::Testing::ExpectedResponses.full_profile_hash_for_player1, &block)
    connection.stub :get_full_player_profile_hash, stubbed_response do 
      yield 
    end
  end  

  def stub_team_members_query(stubbed_response=Playlyfe::Testing::ExpectedResponses.full_team1_members_hash, &block)
    connection.stub :get_full_team_members_hash, stubbed_response do 
      yield 
    end
  end  

  def stub_leaderboards_query(stubbed_response=Playlyfe::Testing::ExpectedResponses.full_leaderboards_array, &block)
    connection.stub :get_full_leaderboards_array, stubbed_response do 
      yield 
    end
  end 

  def stub_leaderboard_query(stubbed_response, &block)
    connection.stub :get_full_leaderboard_hash, stubbed_response do 
      yield 
    end
  end 

 

end    
