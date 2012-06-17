require 'test/unit'
require 'shoulda'
require 'mocha'
require 'resque'

TEST_DIR_BASE = File.dirname(File.expand_path(__FILE__))

require File.expand_path(File.join(TEST_DIR_BASE, '/../resque-uuid'))

#
# make sure we can run redis.  we run an actual redis-server to enqure resque push/pop still works properly
#
if !system("which redis-server")
  puts '', "** can't find `redis-server` in your path"
  puts "** try running `sudo rake install`"
  abort ''
end

# startup and shutdown of test redis server more or less stolen directly from resque test_helper
def startup_test_redis
  `redis-server #{TEST_DIR_BASE}/redis-test.conf`
  Resque.redis = 'localhost:9736'
end

def shutdown_test_redis
  processes = `ps -A -o pid,command | grep [r]edis-test`.split("\n")
  pids = processes.map { |process| process.split(" ")[0] }
  `rm -f #{TEST_DIR_BASE}/dump.rdb`
  pids.each { |pid| Process.kill("KILL", pid.to_i) }
end

# define another after_fork to ensure we don't mess up other after_forks that might get created
Resque.after_fork do |job|
  job.payload['old_after_fork'] = true
end

Resque::Plugins::ResqueUUID.enable!
