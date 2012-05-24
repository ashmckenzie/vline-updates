require 'rubygems'
require 'bundler/setup'
Bundler.require(:default, :development)

require File.expand_path('../../lib/init', __FILE__)

CONFIG = YAML.load_file('config/config.yml')

set :base, "#{ENV['HOME']}/#{CONFIG['app']['name']}/current"
set :output, "#{base}/log/cron.log"

send(:every, eval(CONFIG['app']['cron']['frequency']), eval("{ #{CONFIG['app']['cron']['options']} }")) do
  command "cd #{base} && ERRBIT_ENABLE=true APP_ENV=production ./scripts/vline_updates"
end