# config valid only for Capistrano 3.1
lock '3.2.1'

set :application , '60jahreyfu'
set :repo_url    , 'git@fast-sicher.de:jubi.git'
set :log_level   , :info

server '60jahre.yfu.de', user: 'jubi', roles: %w{web app db}

task :deploy do
  on roles(:all) do |host|
    within deploy_to do
      execute :git, 'pull'
      execute 'docker-compose', '-f staging.yml', 'run', 'web', 'bundle install'
      execute 'docker-compose', '-f staging.yml', 'run', 'web', 'rake assets:precompile'
      execute 'docker-compose', '-f staging.yml', 'restart'
    end
  end
end

task default: :deploy
