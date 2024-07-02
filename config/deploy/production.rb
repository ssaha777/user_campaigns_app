server 'ec2-3-81-174-146.compute-1.amazonaws.com', user: 'deploy', roles: %w{app db web}

set :default_env, { 'RAILS_ENV' => 'production' }
set :ssh_options, {
  keys: %w(~/Desktop/user-campaign.pem),
  forward_agent: true,
  auth_methods: %w(publickey)
}

namespace :deploy do
  task :set_rails_env do
    on roles(:app) do
      execute "export RAILS_ENV=production"
    end
  end

  before :starting, :set_rails_env
end
