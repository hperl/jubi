# config valid only for Capistrano 3.1
lock '3.2.1'

set :application , '60jahreyfu'
set :repo_url    , 'git@fast-sicher.de:jubi.git'
set :log_level   , :info
set :deploy_to   , '/home/jubi/homepage'

server '60jahre.yfu.de', user: 'jubi', roles: %w{web app db}

task :deploy do
  on roles(:all) do |host|
    invoke 'update_code'
    invoke 'build'
    invoke 'start_container'
  end
end

task :update_code do
  on roles(:all) do |host|
    within deploy_to do
      within fetch(:stage) do
        execute :git, 'reset --hard HEAD'
        execute :git, 'pull'
      end
    end
  end
end

task :build do
  on roles(:all) do |host|
    within deploy_to do
      execute 'docker-compose', 'run', '--rm', fetch(:stage), 'bundle install'
      execute 'docker-compose', 'run', '--rm', fetch(:stage), 'rake assets:precompile'
      execute 'docker-compose', 'run', '--rm', fetch(:stage), 'rake db:migrate'
    end
  end
end

task :start_container do
  on roles(:all) do |host|
    within deploy_to do
      execute 'docker-compose', 'build', fetch(:stage)
      execute 'docker-compose', 'up -d', fetch(:stage)
    end
    invoke 'status'
  end
end

task :status do
  on roles(:all) do |host|
    within deploy_to do
      puts capture('docker-compose', 'ps')
    end
  end
end

task :setup do
  on roles(:all) do |host|
    within deploy_to do
      %w(staging production).each do |stage|
        execute :mkdir, '-p', File.join('sockets', stage)
      end

      %w(staging production).each do |stage|
        unless test "[ -d #{File.join deploy_to, stage} ]"
          execute :git, "clone git@github.com:hperl/jubi.git #{stage}"
        end
        execute 'docker-compose', 'run', '--rm', stage, 'rake db:setup'
      end
    end
  end
end

task :stop do
  on roles(:all) do |host|
    within deploy_to do
      execute 'docker-compose', '-f deploy.yml', 'stop'
    end
  end
end

task :start do
  on roles(:all) do |host|
    within deploy_to do
      execute 'docker-compose', '-f deploy.yml', 'up -d'
    end
  end
end

task :restart do
  on roles(:all) do |host|
    within deploy_to do
      execute 'docker-compose', '-f deploy.yml', 'restart web'
    end
  end
end


task default: :deploy
