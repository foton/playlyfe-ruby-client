require_relative '../../playlyfe_test_class.rb'

module Playlyfe
  class PlayerTest < Playlyfe::Test

    def setup 
      stub_game_query do
        @game=connection.game
      end

      #we need players and teams uploaded in front
      stub_players_query do
        @game.players
      end  

      stub_teams_query do
        @game.teams
      end  

      @player = @game.players.find("player1")
    
    end
      
    def test_build_from_hash
      player = Playlyfe::V2::Player.new({ "id"=> "player1", "alias"=> "player1_alias", "enabled"=> true}, nil)
      assert_equal "player1", player.id
      assert_equal "player1_alias", player.alias
      assert player.enabled?
    end

    def test_is_enabled  
      assert Playlyfe::V2::Player.new({ "id"=> "player1", "alias"=> "player1_alias", "enabled"=> true}, nil).enabled?
    end  

    def test_is_disabled
      refute Playlyfe::V2::Player.new({ id: "player1", alias: "player1_alias", enabled: false}, nil).enabled?
      #default is disabled
      refute Playlyfe::V2::Player.new({ id: "player1", alias: "player1_alias"}, nil).enabled?
    end  

    def test_get_roles_in_teams
      stub_player_profile_query do
        teams= @player.teams #this will load profile with teams and scores
        assert_equal 2, teams.size
        
        for team in teams
          roles =[]
          case team.name
            when "Team1 for RUby client"
              roles= ["Captain","Private"] 
            when "Team 2 baased on Team 1 template"
              roles= ["Captain"] 
          end  

          assert_equal roles, @player.roles_in_team(team) 
        end  
      end  
    end

    def test_get_empty_roles_for_no_teams
      connection.stub :get_full_player_profile_hash, {"teams" => []} do 
        assert_equal [], @player.roles_in_team(@game.teams.first)
      end
    end

    
    def test_get_empty_roles_for_unregistered_team
      team=Playlyfe::V2::Team.new({"id" => "not_in_player_teams"},@game)
      stub_player_profile_query do 
        assert_equal [], @player.roles_in_team(team)
      end

    end
      
    def test_get_empty_teams
      connection.stub :get_full_player_profile_hash, {"teams" => []} do 
        assert_equal [], @player.teams
      end
    end

    def test_raise_exception_if_players_team_is_not_in_game_teams          
      connection.stub :get_full_player_profile_hash, {"teams" => [{"id" => "ttt", "name" => "not in game team"}]} do 
        begin
          @player.teams
        rescue Playlyfe::PlayerError => e
          assert_equal "Team not found", e.name 
          assert_equal "Team 'ttt' from player1 player profile was not found between game.teams!", e.message
        end
      end
    end
      
    def test_get_teams
      stub_player_profile_query do
        teams= @player.teams #this will load profile with teams and scores
     
        assert_equal 2, teams.size
        assert_equal ["Team1 for RUby client","Team 2 baased on Team 1 template"].sort, (teams.map {|t| t.name}).sort
      end  
    end  
      
    def test_get_scores
      stub_player_profile_query do
        scores= @player.scores  #this will load profile with teams and scores
       
        assert_equal 2, scores[:points].size
        assert_equal 1, scores[:sets].size
        assert_equal 1, scores[:states].size
        assert_equal 1, scores[:compounds].size

        assert_equal 4, scores[:points][:plus_points]
        assert_equal 22, scores[:points][:test_points]
        assert_equal [
                      {name: "Hammer", count: 2}, 
                      {name: "Screwdriver", count: 1}, 
                      {name: "Multitool", count: 1}
                     ], scores[:sets][:toolbox]
        assert_equal "Guild leader", scores[:states][:experience]
        assert_equal 21, scores[:compounds][:compound_metric]
      end  
    end  

    def test_get_profile_image
      skip 
    end  

    def test_get_activity_feed
      skip 
    end  

    def test_get_notifications
      skip 
    end  

    def test_play_action
      skip
    end  

  end
end
