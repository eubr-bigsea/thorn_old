app_path = File.expand_path(File.dirname(__FILE__) + '/../..')
working_directory "#{app_path}/current"
worker_processes 4
listen "/tmp/thorn.sock", backlog: 64
pid "#{app_path}/shared/tmp/pids/unicorn.pid"
timeout 60
stderr_path "log/unicorn.stderr.log"
stdout_path "log/unicorn.stdout.log"

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
