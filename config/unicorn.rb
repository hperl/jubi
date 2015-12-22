rails_env = ENV['RAILS_ENV'] || 'production'

case rails_env
when 'production'
  worker_processes 2
when 'staging'
  worker_processes 1
when 'development'
  worker_processes 1
end

if rails_env == 'production' || rails_env == 'staging'
  working_directory '/app'
  listen "/socket/unicorn.sock"
  timeout 30

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
end
