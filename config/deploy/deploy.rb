# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'boardworld'
set :repo_url, 'https://github.com/newism/circleci.git'

set :app_path,              "app"
set :web_path,              "web"
set :log_path,              "var/logs"
set :cache_path,            "var/cache"

set :composer_install_flags, ' --no-interaction --optimize-autoloader'

# Default branch is :master
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push(fetch(:app_path) + '/config/parameters.json')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push(fetch(:log_path), fetch(:cache_path), fetch(:web_path) + '/uploads', fetch(:app_path) + '/../vendor')

set :file_permissions_paths, [fetch(:log_path), fetch(:cache_path), fetch(:web_path) + '/uploads']
set :file_permissions_users, ["www-data"]

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end

SSHKit.config.command_map[:composer] = "/usr/local/bin/composer"
