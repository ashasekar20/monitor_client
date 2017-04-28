require_relative "lib/common"
require_relative "lib/actions"

if ARGV.empty?
 puts "Args mandatory for monitoring client" 
exit 1
end

name = url = ""
if ARGV.size == 2
	name = ARGV[0]
	url = ARGV[1]
	option = "1"
elsif ARGV.size == 1
	url = ARGV[0]
	option = "2"
end
@client = MonitorClient.new(API_KEY, name, url)
action_name = MONITOR_ACTIONS[option]
@client.method(action_name).call
exit 1

