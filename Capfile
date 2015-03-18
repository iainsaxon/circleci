set :deploy_config_path, 'config/deploy/deploy.rb'
set :stage_config_path, 'config/deploy'

require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/composer'

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
