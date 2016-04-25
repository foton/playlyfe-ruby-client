# playlyfe-ruby-client
Model/Object oriented Playlyfe client based on Playlyfe SDK.
It's focus is abstract direct calls with hand written routes into ActiveRecorrd style "save", "update" style.
All game is defined at Playlyfe, this client serves only for sending actions and reading results.

## Classes
* Game
* Action
* Player
* Leaderboard

### Game 
  base client class to interact with Playlyfe game
  has_many available_actions
  has_many players
  has_many leaderboards

### Action
  Equivalent to Playlyfe action (or some complicated rule)

### Player
  Player of game , his profile and metrics/achievements/levels

### Leaderboard
  Leaderboards of the Game

  
