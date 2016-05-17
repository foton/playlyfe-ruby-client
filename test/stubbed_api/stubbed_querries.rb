module StubbedQuerries
  
  def stub_game_query &block
    connection.stub :get_full_game_hash, full_game_hash do 
      yield 
    end
  end  

  def stub_players_query &block
    connection.stub :get_full_players_hash, full_players_hash do 
      yield 
    end
  end  

  def stub_teams_query &block
    connection.stub :get_full_teams_hash, full_teams_hash do 
      yield 
    end
  end 

  def stub_player_profile_query(stubbed_response=full_profile_hash_for_player1, &block)
    connection.stub :get_full_player_profile_hash, stubbed_response do 
      yield 
    end
  end  

  def stub_team_members_query(stubbed_response=full_team1_members_hash, &block)
    connection.stub :get_full_team_members_hash, stubbed_response do 
      yield 
    end
  end  
end    
