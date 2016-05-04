require_relative '../playlyfe_test_class.rb'

module Playlyfe
  class GameTest < Playlyfe::Test

 
     
    def test_find_game_hash
      expected_hash= {
        "name"=>"Playlyfe Hermes",
        "version"=>"v1",
        "status"=>"ok",
        "game"=> {
          "_errors"=>[],
          "access"=>"PUBLIC",
          "description"=>"",
          "id"=>"lms",
          "image"=>"default-game",
          "listed"=>false,
          "title"=>"LMS",
          "type"=>"native",
          "timezone"=>"Asia/Kolkata",
          "template"=>"custom",
          "created"=>"2014-06-18T07:43:25.000Z"
        }
      }

      returned_hash=connection.game.to_hash
        
      assert_equal expected_hash["name"], returned_hash["name"], "[\"name\"] is '#{returned_hash["name"]}'' but expected is '#{expected_hash["name"]}'"
      assert_equal expected_hash["version"], returned_hash["version"], "[\"version\"] is '#{returned_hash["version"]}'' but expected is '#{expected_hash["version"]}'"
      assert_equal expected_hash["status"], returned_hash["status"], "[\"status\"] is '#{returned_hash["status"]}'' but expected is '#{expected_hash["status"]}'"

      expected_hash["game"].keys.each do |key|
        assert_equal expected_hash["game"][key], returned_hash["game"][key], "[\"game\"][\"#{key}\"] is '#{returned_hash["game"][key]}'' but expected is '#{expected_hash["game"][key]}'"
      end  
    end  


    def test_get_game_image
      skip
      # assert_equal "some_png", @game.image(:original)
      # assert_equal "some_png", @game.image(:large)
      # assert_equal "some_png", @game.image(:medium)
      # assert_equal "some_png", @game.image(:small)
      # assert_equal "some_png", @game.image(:icon)
    end

    def test_get_game_info
      skip # Playlyfe::Game.find(:my_game)
    end  

  end
end
