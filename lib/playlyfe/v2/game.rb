
require_relative "./player_collection.rb"
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
        Playlyfe::V2::Game.new(conn)
      end  
         
      def players
        @players ||= Playlyfe::V2::PlayerCollection.new(self)
      end
     

      def actions
      end

      def leaderboards
      end

      def image_data(style=:original)
        data=connection.get_game_image_data
        puts(data)
      end  

      private

        def initialize(conn)    
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
          @game_hash=connection.get_game_hash
          #name is not name of Game but rather connection   @name= game_hash["name"]
          @description=game_hash["description"]
          @id=game_hash["id"]
          @image=game_hash["image"]
          @title=game_hash["title"]
          @type=game_hash["type"]
          @timezone=game_hash["timezone"] #TODO converion to TZInfo::Timezone ? http://www.rubydoc.info/gems/tzinfo/frames
          @created_at=Time.parse(game_hash["created"])
        end  

     

    end
  end  
end    
