require 'rubygems'
require 'bundler/setup'
Bundler.require(:default, :development)

require File.expand_path('../../lib/init', __FILE__)

set :base, "#{ENV['HOME']}/#{$CONFIG.name}/current"
set :output, "#{base}/log/cron.log"

every $CONFIG.cron.frequency do
  command "cd #{base} && ERRBIT_ENABLE=true APP_ENV=production ./scripts/vline_updates"
end