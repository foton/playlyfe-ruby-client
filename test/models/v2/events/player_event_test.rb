require_relative '../../../playlyfe_test_class.rb'

module PlaylyfeClient
  class PlayerEventTest < PlaylyfeClient::Test

    def setup
      stub_game_query { @game=connection.game}
      stub_metrics_query { @game.metrics }
      stub_all_actions_query { @game.available_actions }
      stub_players_query { @game.players }  
      stub_teams_query { @game.teams }
    end  

      # PlaylyfeClient::PlayerEvent::LevelChangeEvent
      # PlaylyfeClient::PlayerEvent::AchievementEvent
      # PlaylyfeClient::PlayerEvent::ActionPlayEvent
      # PlaylyfeClient::PlayerEvent::CustomRuleAppliedEvent
      # PlaylyfeClient::PlayerEvent::ScoreUpdatedByAdminEvent
    
    def test_can_build_level_change_event
       event=PlaylyfeClient::V2::PlayerEvent::Base.build(PlaylyfeClient::Testing::ExpectedResponses.level_up_event_hash, @game)

       assert_equal "player1", event.actor_id
       assert_equal "player1_alias", event.actor_alias
       #assert_equal player1, event.acting_player
       assert_equal "leveling_in_experience", event.rule
       assert event.action.nil?
       assert event.process.nil?
       assert_equal Time.utc(2016,5,17,9,52,45.582).to_f, event.timestamp.to_f
       assert_equal 1, event.changes.size

       change=event.changes.first
       assert_equal PlaylyfeClient::V2::StateMetric , change[:metric].class
       assert_equal "experience", change[:metric].id
       assert_equal ["Journeyman","Master"], change[:delta]
    end  

    def test_can_build_achievement_event
       event=PlaylyfeClient::V2::PlayerEvent::Base.build(PlaylyfeClient::Testing::ExpectedResponses.achievement_event_hash, @game)

       assert_equal "player1", event.actor_id
       assert_equal "player1_alias", event.actor_alias
       assert_equal "get_a_multitool", event.rule
       assert event.action.nil?
       assert event.process.nil?
       assert_equal Time.utc(2016,5,17,9,53,4.387).to_f, event.timestamp.to_f
       assert_equal 2, event.changes.size
       
       change1=event.changes.first
       assert_equal "toolbox", change1[:metric].id
       assert_equal PlaylyfeClient::V2::SetMetric , change1[:metric].class
       assert_equal [nil,"1","Multitool"], change1[:delta]

       change2=event.changes.last
       assert_equal "compound_metric", change2[:metric].id
       assert_equal PlaylyfeClient::V2::CompoundMetric , change2[:metric].class
       assert_equal ["22","21"], change2[:delta]
    end  

    def test_can_build_action_played_event
       player=@game.players.find("player1")
       event=PlaylyfeClient::V2::PlayerEvent::Base.build(PlaylyfeClient::Testing::ExpectedResponses.ghspp_action_play_event_hash, @game, player)

       assert_equal "player1", event.actor_id
       assert_equal "player1_alias", event.actor_alias
       assert event.rule.nil?
       assert_equal "get_hammer_screwdriver_and_plus_point", event.action
       assert event.process.nil?
       assert_equal 1, event.count
       assert_equal Time.utc(2016,5,20,13,20,22.2220001).to_f, event.timestamp.to_f
       assert_equal 3, event.changes.size
       
       change1=event.changes.first
       assert_equal "toolbox", change1[:metric].id
       assert_equal PlaylyfeClient::V2::SetMetric , change1[:metric].class
       assert_equal [nil,"1","Hammer"], change1[:delta]

       change2=event.changes[1]
       assert_equal "plus_points", change2[:metric].id
       assert_equal PlaylyfeClient::V2::PointMetric , change2[:metric].class
       assert_equal ["2","3"], change2[:delta]

       change3=event.changes.last
       assert_equal "toolbox", change3[:metric].id
       assert_equal PlaylyfeClient::V2::SetMetric , change3[:metric].class
       assert_equal [nil,"1","Screwdriver"], change3[:delta]
    end 
  end
end    
