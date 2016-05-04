
#require_relative "./player.rb"
#require_relative "./action.rb"
#require_relative "./ledaderboard.rb"

require_relative "../game.rb"

module Playlyfe
  module V2
    #Game is 1:1 to connection, so only one instance per connection
    #finding is done by credentials
    class Game < Playlyfe::Game

      attr_reader :game_hash, :description, :id, :type, :timezone, :created_at

      def self.find_by_connection(conn)
        game_hash=conn.get('/admin')
        Playlyfe::V2::Game.new(game_hash, conn)
      end  
         
      def players
      end
      
      def actions
      end

      def leaderboards
      end

      private

        def initialize(game_hash,conn)    
           super(conn)
           # expected_game_hash= {
           #        "name"=>"Playlyfe Hermes",
           #        "version"=>"v1",
           #        "status"=>"ok",
           #        "game"=> {
           #          "_errors"=>[],
           #          "access"=>"PUBLIC",
           #          "description"=>"",
           #          "id"=>"lms",
           #          "image"=>"default-game",
           #          "listed"=>false,
           #          "title"=>"LMS",
           #          "type"=>"native",
           #          "timezone"=>"Asia/Kolkata",
           #          "template"=>"custom",
           #          "created"=>"2014-06-18T07:43:25.000Z"
           #        }
           #      }
          @game_hash=game_hash
          @name= game_hash["name"]
          @description=game_hash["game"]["description"]
          @id=game_hash["game"]["id"]
          @image=game_hash["game"]["image"]
          @title=game_hash["game"]["title"]
          @type=game_hash["game"]["type"]
          @timezone=game_hash["game"]["timezone"]
          @created_at=Time.parse(game_hash["game"]["created"])
        end  

    end
  end  
end    
