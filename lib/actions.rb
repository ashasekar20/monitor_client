require 'json'
require "httparty"

require_relative "log_handler"
require_relative "common"

class MonitorClient
 def initialize(api_key, name, url)
   @name = name
   @url = url
   @api_key = api_key
 end

 

 def add_monitor
  api_url = API_URL + "newMonitor"
  req_body = {
  "api_key" => "#{@api_key}",
    "format" => "json",
    "type" => 1,
    "friendly_name" => "#{@name}",
    "url" => "#{@url}"
}.to_json
  response = invoke_api(api_url, req_body)
  if response["stat"].downcase == "ok"
  	puts "Monitor added"
    return true
  else
   LOG.error(response["error"]["message"])
   LOG.error("Monitor with URL #{@url} can not be added")
 end
 return false
end

 def remove_monitor
  monitor = fetch_monitor_data
  if ! (monitor.empty?)
   monitor = monitor[0]
   monitor_id = monitor["id"]
   api_url = API_URL + "deleteMonitor"
   req_body = {
  "api_key" => "#{@api_key}",
    "format" => "json",
    "id" => monitor_id
}.to_json
   response = invoke_api(api_url, req_body)
   if response["stat"].downcase == "ok"
   	puts "Monitor deleted"
    return true
   else
   LOG.error(response["error"]["message"])
   LOG.error("Monitor with URL #{@url} is not deleted")
  end
else
  LOG.error("Monitor with URL '#{@url}' is not found")
 end
 return false
end

 def fetch_monitor_data
  api_url = API_URL + "getMonitors"
  req_body = {
  "api_key" => "#{@api_key}",
    "format" => "json",
    "logs" => "1"
}.to_json
  response = invoke_api(api_url, req_body)
  monitors = response["monitors"]
  return monitors.select{|monitor| monitor["url"]== @url} 
 end


 def invoke_api(api_url, req_body)
 	response =  HTTParty.post(api_url,
    :body=> req_body,
    :headers => {
      'Content-Type' => 'application/json', 
      'Accept' => 'application/json'
    }
  )
 	return parse_response(response.response.body)
 end

 def parse_response(data)
  begin
   return JSON.parse(data)
  rescue JSON::ParserError => ex
   LOG.error(data)
   LOG.error("Invalid JSON Data")
  end
 end

end
