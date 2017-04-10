app_path = "/usr/src/app"
working_directory "#{app_path}"
worker_processes 4
listen "/tmp/thorn.sock", backlog: 64
listen 3000
pid "#{app_path}/tmp/unicorn.pid"
timeout 60
stderr_path "/dev/stdout"

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
