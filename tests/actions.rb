require 'test/unit'
include Test::Unit::Assertions

require_relative File.expand_path('../../lib/actions', __FILE__)

require_relative 'common'
	

class TestMonitor < Test::Unit::TestCase
  def test_new_monitor
  	client = MonitorClient.new(KEY, MONITOR_NAME, MONITOR_URL)
    assert_equal(true, client.add_monitor) 
 	end

 def test_delete_monitor
 	client = MonitorClient.new(KEY, MONITOR_NAME, DELETE_URL)
 	assert_equal(true, client.remove_monitor) 
 end
end