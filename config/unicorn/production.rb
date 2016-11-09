working_directory "/home/ec2-user/torn/current"
worker_processes 4
listen "/tmp/torn.sock", backlog: 64
timeout 60
pid "/home/ec2-user/torn/shared/tmp/pids/unicorn.pid"
stderr_path "log/unicorn.stderr.log"
stdout_path "log/unicorn.stdout.log"

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
