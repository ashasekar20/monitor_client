
require 'logger'

LOG = Logger.new(STDOUT)
LOG.level = Logger::WARN
original_formatter = Logger::Formatter.new
LOG.formatter = proc do |severity, datetime, progname, msg|
  "#{severity}: #{msg}\n"
end


