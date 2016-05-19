require_relative "../collection.rb"
require_relative "../leaderboard/unknown_leaderboard.rb"
require_relative "../leaderboard/teams_leaderboard.rb"
require_relative "../leaderboard/players_leaderboard.rb"

module Playlyfe
  module V2
    class LeaderboardCollection < Playlyfe::V2::Collection
     
      def find(str)
        (@items.detect {|pl| pl.name == str || pl.id == str})
      end  

      def for_teams
        @items.select {|lbd| lbd.kind_of?(Playlyfe::V2::TeamsLeaderboard)}
      end
        
      def for_players
        @items.select {|lbd| lbd.kind_of?(Playlyfe::V2::PlayersLeaderboard)}
      end  
         
      
      private

        def initialize(game)  
          super
          @items=[]
          fill_items(game.connection.get_full_leaderboards_array)
        end
        
        def fill_items(hash_array)  
          hash_array.each do |definition_hash|
            data_hash=game.connection.get_full_leaderboard_hash(definition_hash["id"])
            @items << Playlyfe::V2::UnknownLeaderboard.create_from(definition_hash.merge(data_hash), @game)
          end  
        end  


    end  
  end
end    
     
 
