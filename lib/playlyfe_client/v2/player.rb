require_relative "../player.rb"

module PlaylyfeClient
  module V2
    class Player < PlaylyfeClient::Player
     
      attr_reader :enabled ,:alias, :id

      def self.create(pl_hash, game)
        unless pl_hash.has_key?(:id) && pl_hash.has_key?(:alias)
          fail PlaylyfeClient::PlayerError.new("{\"error\": \"keys missing\", \"error_description\": \"Player's hash is missing values for keys :id and :alias!\"}")
        end  
        
        p=self.new( game.connection.post_create_player( pl_hash.select { |key, value| [:id, :alias].include?(key) } ), game )
        game.players.add(p)
        p
      end   

      def enabled?
        enabled
      end  

      def play(action)
        begin
          game.connection.post_play_action(action.id, self.id)
          @profile_hash= game.connection.get_full_player_profile_hash(self.id)
          @scores=fill_scores
        rescue PlaylyfeClient::ActionRateLimitExceededError => e
          unless game.ignore_rate_limit_errors  
            fail e
          end
        end  
      end
      
      def scores
        @scores||=fill_scores
      end

      def roles_in_team(team)
        teams.empty? ? [] : (@teams_roles[team.id].nil? ? [] : @teams_roles[team.id])
      end 

      def teams
        @teams||= fill_teams
      end

      def teams_leaderboards
        game.leaderboards.for_teams
      end  

      def players_leaderboards
        game.leaderboards.for_players
      end  

      def activities(start_time=nil,end_time=nil)
        unless defined?(@activities)
          #loading all activities for player (not restricted to some time period, ALL of them!)
          @activities = build_activities_from(game.connection.get_full_activity_feed_array(self.id,self.game.created_at,Time.now.utc))
        end  
        
        activities=@activities  
        
        if start_time
          activities=activities.select {|act| act["timestamp"] > start_time.utc.strftime("%Y-%m-%dT%H:%M:%S.%LZ") }
        end    

        if end_time
          activities=activities.select {|act| act["timestamp"] < end_time.utc.strftime("%Y-%m-%dT%H:%M:%S.%LZ") }
        end   
        
        return activities
      end
   
      private 
      
        def initialize(player_hash, game)
          super(game)
          @id=player_hash[:id] || player_hash["id"]
          @alias=player_hash[:alias] || player_hash["alias"]
          @enabled=player_hash[:enabled] || player_hash["enabled"] || false
        end  

        def profile_hash
          @profile_hash||= game.connection.get_full_player_profile_hash(self.id)
        end  

        def fill_teams
          teams=[]
          @teams_roles={}
          profile_hash["teams"].each do |team_hash|
            team=game.teams.find(team_hash["id"])

            #all teams should be listed in game, so if nothing is found raise exception
            if team.nil?
              fail PlaylyfeClient::PlayerError.new("{\"error\": \"Team not found\", \"error_description\": \"Team '#{team_hash["id"]}' from #{self.id} player profile was not found between game.teams!\"}")
            end  
            
            teams << team
            @teams_roles[team.id]=team_hash["roles"]

          end  
          teams
        end  

        def fill_scores
          scores={points: {} ,sets: {}, states: {}, compounds: {}}
          profile_hash["scores"].each do |score|
            case score["metric"]["type"]
              when "point"
                scores[:points][score["metric"]["id"].to_sym]=score["value"].to_i
              when "set"
                scores[:sets][score["metric"]["id"].to_sym]=sets_metric_value_from(score["value"])
              when "state"
                scores[:states][score["metric"]["id"].to_sym]=score["value"]["name"] #"value": { "name": "Hell", "description": "The plane of demons" }
              when "compound"
                scores[:compounds][score["metric"]["id"].to_sym]=score["value"].to_i
            end

          end  
          scores
        end  

        def sets_metric_value_from(value)
          (value.each.collect {|item| {name: item["name"], count: item["count"].to_i} } )
        end  

        def build_activities_from(array_of_hashes)
          #https://dev.playlyfe.com/docs/events.html
          #TODO: DO a Events :: now, just simple hashes
          array_of_hashes
        end  

    end
  end
end  
