#RUN SINGLE TEST?  
#rake test TEST=test/models/identity_test.rb TESTOPTS="--name=test_can_be_created_from_auth_without_user -v"

#RUN ALL TESTS IN FILE?
#rake test TEST=test/models/identity_test.rb 

require "minitest/reporters"
require_relative "./rake_rerun_reporter"
require 'minitest/autorun'

reporter_options = { color: true, slow_count: 5, verbose: false, rerun_prefix: "rm -f log/*.log && be" }
#Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]
Minitest::Reporters.use! [Minitest::Reporters::RakeRerunReporter.new(reporter_options)]


require_relative "./playlyfe_test_class.rb"

