# PlaylyfeClient

Model/Object oriented PlaylyfeClient client based on PlaylyfeClient SDK.
It's focus is abstract direct calls with hand written routes into calling methods on `game`.
All aspects of game is defined at PlaylyfeClient, this client serves only for sending actions and reading results and stats.

## Base Classes
* Game
* Action
* Player
* Team
* Leaderboard
* Metric

### Game 
  base client class to interact with PlaylyfeClient game
  * has many available actions
  * has many players
  * has many teams
  * has many metrics
  * has many leaderboards

### Action
  Equivalent to PlaylyfeClient action (or some complicated rule)

### Player
  Player of game , his profile and scores 

### Leaderboard
  Leaderboards of the Game
 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'playlyfe_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install playlyfe_client

## Usage

You have to setup a client at PlaylyfeClient which can access API (only paid plans) form your backend.
Client shoul have 'Client Credential Flow' , all checks at config page should be on YES and should have all scopes with RW access.

Then in your code initialize connection:
  
    $ conn= PlaylyfeClient::V2::Connection.new(
        version: 'v2',
        client_id: CLIENT_ID,
        client_secret: CLIENT_SECRET,
        type: 'client'
      )
    
    game=connection.game

With game in hand you can start to ask:
    
    pl1=game.player.first
    pl1.scores
    game.teams.all
    game.metrics
    a=game.actions.find("my_action_id")

or play

    pl1.play(a)
    a.play_by(pl1) #equivalent to previous line

or add players
   
    PlaylyfeClient::V2::Player.create({id: "batman", alias: "Bruce Wayne"}, game)


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/foton/playlyfe_client.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

