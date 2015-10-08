rails_env = ENV['RAILS_ENV'] || 'production'

if rails_env == 'production'
  worker_processes 2
  app_path = '/srv/apps/but'
else
  worker_processes 1
  app_path = '/srv/apps/but-staging'
end

user 'deploy', 'deploy'
working_directory "#{app_path}/current"
listen "#{app_path}/unicorn.sock"
timeout 30

pid "#{app_path}/shared/pids/unicorn.pid"

stderr_path "#{app_path}/shared/log/unicorn.stderr.log"
stdout_path "#{app_path}/shared/log/unicorn.stdout.log"

preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
  GC.copy_on_write_friendly = true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
