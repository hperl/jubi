# config valid only for Capistrano 3.1
lock '3.2.1'

set :application , 'my_app_name'
set :repo_url    , 'git@fast-sicher.de:but.git'
set :deploy_via  , :remote_cache
set :copy_exclude, %w(.git)
set :use_sudo    , false

set :log_level   , :debug

server 'fast-sicher.de', user: 'deploy', roles: %w{web app db}

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end

  desc "reload the database with seed data"
  task :seed do
    on primary :db do
      within current_path do
        with rails_env: fetch(:stage) do
          execute :rake, 'db:seed'
        end
      end
    end
  end
end
after 'deploy:updated', 'deploy:seed'

#desc 'copy ckeditor nondigest assets'
#task :copy_nondigest_assets do
  #run "cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} ckeditor:create_nondigest_assets"
#end
#after 'deploy:assets:precompile', 'copy_nondigest_assets'
