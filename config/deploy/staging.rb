set :deploy_to, '/srv/apps/but-staging'
set :rails_env, 'staging'
set :branch,    'master'

set :unicorn_pid, '/srv/apps/but-staging/shared/pids/unicorn.pid'
set :unicorn_config_path, "#{current_path}/config/unicorn.rb"

namespace :deploy do
  task :copy_db do
    on roles(:db) do |host|
      dump_file = '/tmp/but.dump'
      execute :pg_dump, "-n public -Fc -c but > #{dump_file}"
      execute :pg_restore, "-Oc -d but_staging #{dump_file}"
      execute :rm, dump_file
      invoke 'deploy:migrate'
    end
  end
end
after 'deploy:updated', 'deploy:copy_db'

