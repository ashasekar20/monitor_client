require "yaml"

@app_path = File.expand_path('../..', __FILE__)

CREDENTIALS_FILE = "#{@app_path}/config/credentials.yml"
credentials = YAML.load_file(CREDENTIALS_FILE)
API_KEY = credentials["api_key"]

MONITOR_ACTIONS = {"1" => "add_monitor",
"2" => "remove_monitor"}

API_URL = "https://api.uptimerobot.com/v2/"