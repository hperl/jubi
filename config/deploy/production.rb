set :rails_env, 'production'

namespace :db do
  task :download do
    on roles(:db) do |host|
      remote_dump_file = '/tmp/but.dump'
      local_dump_file = "#{host}_db.dump"
      begin
        execute :pg_dump, "-n public -Fc -c but > #{remote_dump_file}"
        download! remote_dump_file, local_dump_file
      ensure
        execute :rm, remote_dump_file
      end
      run_locally do
        begin
          execute :pg_restore, "-Oc -d but-development #{local_dump_file}"
          execute :rake, 'db:migrate'
        ensure
          execute :rm, local_dump_file
        end
      end
    end
  end
end

