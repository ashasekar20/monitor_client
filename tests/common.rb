require "yaml"
@app_path = File.dirname(__FILE__)

CREDENTIAL_FILE = "#{@app_path}/config/credentials.yml"
credentials = YAML.load_file(CREDENTIAL_FILE)
KEY = credentials["api_key"]
MONITOR_NAME = credentials["monitor_name"]
MONITOR_URL = credentials["monitor_url"]
DELETE_URL = credentials["delete_url"]


