require_relative '../../playlyfe_test_class.rb'

module PlaylyfeClient
  class PlayerTest < PlaylyfeClient::Test

    def setup 
      super
      stub_game_query { @game=connection.game }
      #we need players and teams uploaded in front
      stub_players_query { @game.players }
      stub_teams_query { @game.teams}

      stub_leaderboards_query do
       
        #stubbing method directly, so it responds with expected responses and do not call real api
        connection.dummy_player_id = @game.players.first.id
        def connection.get_full_leaderboard_hash(leaderboard_id, cycle="alltime", player_id=dummy_player_id) 
          case leaderboard_id 
          when 'leaderboard_plus_points'
            return PlaylyfeClient::Testing::ExpectedResponses.full_teams_leaderboard_hash
          when 'leaderboard1'  
            return PlaylyfeClient::Testing::ExpectedResponses.full_players_leaderboard_hash
          else
            raise "Uncatched stub for leaderboard_id = #{leaderboard_id}"  
          end
        end  

        @game.leaderboards
      end  

      @player = @game.players.find("player1")
    
    end
      
    def test_build_from_hash
      player = PlaylyfeClient::V2::Player.new({ "id"=> "player1", "alias"=> "player1_alias", "enabled"=> true}, nil)
      assert_equal "player1", player.id
      assert_equal "player1_alias", player.alias
      assert_equal "player1_alias", player.name
      assert player.enabled?
    end

    def test_is_enabled  
      assert PlaylyfeClient::V2::Player.new({ "id"=> "player1", "alias"=> "player1_alias", "enabled"=> true}, nil).enabled?
    end  

    def test_is_disabled
      refute PlaylyfeClient::V2::Player.new({ id: "player1", alias: "player1_alias", enabled: false}, nil).enabled?
      #default is disabled
      refute PlaylyfeClient::V2::Player.new({ id: "player1", alias: "player1_alias"}, nil).enabled?
    end  

    def test_get_roles_in_teams
      stub_player_profile_query(PlaylyfeClient::Testing::ExpectedResponses.full_profile_hash_for_player1) do
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
        player=PlaylyfeClient::V2::Player.new(PlaylyfeClient::Testing::ExpectedResponses.full_profile_hash_for_player1, @game)
        assert_equal [], player.roles_in_team(@game.teams.first)
      end
    end

    
    def test_get_empty_roles_for_unregistered_team
      team=PlaylyfeClient::V2::Team.new({"id" => "not_in_player_teams"},@game)
      stub_player_profile_query(PlaylyfeClient::Testing::ExpectedResponses.full_profile_hash_for_player1) do 
        assert_equal [], @player.roles_in_team(team)
      end

    end
      
    def test_get_empty_teams
      connection.stub :get_full_player_profile_hash, {"teams" => []} do 
        player=PlaylyfeClient::V2::Player.new(PlaylyfeClient::Testing::ExpectedResponses.full_profile_hash_for_player1, @game)
        assert_equal [], player.teams
      end
    end

    def test_raise_exception_if_players_team_is_not_in_game_teams          
      connection.stub :get_full_player_profile_hash, {"teams" => [{"id" => "ttt", "name" => "not in game team"}]} do 
        e=assert_raises(PlaylyfeClient::PlayerError) do
          player=PlaylyfeClient::V2::Player.new(PlaylyfeClient::Testing::ExpectedResponses.full_profile_hash_for_player1, @game)
          player.teams
        end
        assert_equal "Team not found", e.name 
        assert_equal "Team 'ttt' from player1 player profile was not found between game.teams!", e.message
      end
    end
      
    def test_get_teams
      stub_player_profile_query(PlaylyfeClient::Testing::ExpectedResponses.full_profile_hash_for_player1) do
        teams= @player.teams #this will load profile with teams and scores
     
        assert_equal 2, teams.size
        assert_equal ["Team1 for RUby client","Team 2 baased on Team 1 template"].sort, (teams.map {|t| t.name}).sort
      end  
    end  
      
    def test_get_scores
      stub_player_profile_query(PlaylyfeClient::Testing::ExpectedResponses.full_profile_hash_for_player1) do
        scores= @player.scores  #this will load profile with teams and scores
       
        assert_equal 2, scores[:points].size
        assert_equal 1, scores[:sets].size
        assert_equal 1, scores[:states].size
        assert_equal 1, scores[:compounds].size

        assert_equal 19, scores[:points][:plus_points]
        assert_equal 24, scores[:points][:test_points]
        assert_equal [
                      {name: "Multitool", count: 1},
                      {name: "Hammer", count: 1}, 
                      {name: "Screwdriver", count: 1}, 
                     ], scores[:sets][:toolbox]
        assert_equal "Guild leader", scores[:states][:experience]
        assert_equal 23, scores[:compounds][:compound_metric]
      end  
    end  

     def test_get_teams_leaderboards
      real_value= @player.teams_leaderboards
      expected_value=@game.leaderboards.for_teams

      assert_equal expected_value, real_value
    end  

    def test_get_players_leaderboards
      real_value= @player.players_leaderboards
      expected_value=@game.leaderboards.for_players

      assert_equal expected_value, real_value
    end  

    def test_get_profile_image 
      #skip #get /runtime/assets/players/player1  returning PNG image data
    end  

    def test_get_all_activities
      stub_activity_feed(PlaylyfeClient::Testing::ExpectedResponses.full_player2_activity_feed_array) do
        activities=@player.activities() 
        assert_equal 7, activities.size
        #activities are now just simple hashes
        assert_equal 4, (activities.select {|a| a["event"] == "action"}).size
        assert_equal 1, (activities.select {|a| a["event"] == "level"}).size
        assert_equal 1, (activities.select {|a| a["event"] == "create"}).size
        assert_equal 1, (activities.select {|a| a["event"] == "invite:accept"}).size
      end  
    end    

    def test_get_activities_for_a_period
      stub_activity_feed(PlaylyfeClient::Testing::ExpectedResponses.full_player2_activity_feed_array) do
        activities=@player.activities(Time.parse("2016-05-13T08:16:41.000Z"), Time.parse("2016-05-17T10:00:00.000Z"))
        assert_equal 3, activities.size
        #activities are now just simple hashes
        assert_equal 1, (activities.select {|a| a["event"] == "action"}).size
        assert_equal 0, (activities.select {|a| a["event"] == "level"}).size
        assert_equal 1, (activities.select {|a| a["event"] == "create"}).size
        assert_equal 1, (activities.select {|a| a["event"] == "invite:accept"}).size
      end  
    end    

    def test_play_action
      # already verified by action_test.rb#test_play_action
    end  

    def test_have_badges
      stub_player_profile_query(PlaylyfeClient::Testing::ExpectedResponses.full_profile_hash_for_player1) do
        assert_equal @player.items_from_sets, @player.badges    
      end  
    end

    def test_have_items_from_sets
      stub_player_profile_query(PlaylyfeClient::Testing::ExpectedResponses.full_profile_hash_for_player1) do
        expected_value=[
          {name: "Hammer", count: 1, metric_id: "toolbox"}, 
          {name: "Multitool", count: 1, metric_id: "toolbox"}, 
          {name: "Screwdriver", count: 1, metric_id: "toolbox"}
        ]

        assert_equal expected_value, @player.items_from_sets
      end  
    end  
    
    def test_have_points
      stub_player_profile_query(PlaylyfeClient::Testing::ExpectedResponses.full_profile_hash_for_player1) do
        
        expected_value=[
          {count: 19, metric_id: "plus_points"},
          {count: 24, metric_id: "test_points"}
        ]
        assert_equal expected_value, @player.points
      end  
    end
 
    def test_have_levels
      stub_player_profile_query(PlaylyfeClient::Testing::ExpectedResponses.full_profile_hash_for_player1) do
        assert_equal @player.states, @player.levels
      end  
    end

    def test_have_states
      stub_player_profile_query(PlaylyfeClient::Testing::ExpectedResponses.full_profile_hash_for_player1) do
        expected_value=[{name: "Guild leader", metric_id: "experience"}]
        assert_equal expected_value, @player.states
      end
    end    

    # Ijust realize, that I cannot add players to running as admin manualy on website :-(
    def test_create_player_in_game
      player_h=player_h={id: "newone", alias: "Just born"}
      stub_player_create(PlaylyfeClient::Testing::ExpectedResponses.player_created_hash(player_h)) do
        new_player=PlaylyfeClient::V2::Player.create(player_h, @game)

        assert_equal player_h[:id], new_player.id 
        assert_equal player_h[:alias], new_player.alias
        #check for empty scores and teams?

        refute @game.players.find(player_h[:id]).nil?
      end  
    end 

    def test_raise_error_on_create_already_existing_player
      player_h=player_h={id: "newone", alias: "Just born"}   
      stubbed_response= PlaylyfeClient::Testing::ExpectedResponses.full_error_for_creating_existing_player(player_h[:id])

      stub_player_create( -> (player_h) { raise stubbed_response }) do
        e=assert_raises(PlaylyfeClient::PlayerExistsError) { PlaylyfeClient::V2::Player.create(player_h, @game) }
  
        expected_error=stubbed_response
        assert_equal expected_error.name, e.name
        assert_equal expected_error.message.gsub(/access_token=\w*/,""), e.message.gsub(/access_token=\w*/,"")
      end   
    end  

  end
end
