app_path = '/usr/src/app'
working_directory app_path.to_s
worker_processes 4
listen '/tmp/thorn.sock', backlog: 64
listen 3000
pid "#{app_path}/tmp/unicorn.pid"
timeout 60
stderr_path '/dev/stdout'

before_fork do |_server, _worker|
  defined?(ActiveRecord::Base) && ActiveRecord::Base.connection.disconnect!
end

after_fork do |_server, _worker|
  defined?(ActiveRecord::Base) && ActiveRecord::Base.establish_connection
end
