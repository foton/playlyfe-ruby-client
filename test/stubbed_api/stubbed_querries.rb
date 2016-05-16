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

  def stub_player_profile_query &block
    connection.stub :get_full_player_profile_hash, expected_player1_profile_full_hash do 
      yield 
    end
  end  
end    
