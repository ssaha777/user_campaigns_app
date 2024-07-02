# config valid for current version and patch releases of Capistrano
lock "~> 3.19.1"

set :application, "user_campaigns_app"
set :repo_url, "git@github.com:ssaha777/user_campaigns_app.git"

set :deploy_to, "/var/www/#{fetch(:application)}"

set :rbenv_type, :user
set :rbenv_ruby, '2.7.6'  # Update to your Ruby version
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all

append :linked_files, 'config/database.yml', 'config/master.key'
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system', 'storage'

set :keep_releases, 5

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
