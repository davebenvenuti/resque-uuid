require File.expand_path(File.join(File.dirname(__FILE__), "../../../test_helper"))

class ResqueExtensionsTest < Test::Unit::TestCase
  class << self
    # we need to startup and shutdown a redis server for this test case so we can enqueue resque push/pop still work properly
    def startup
      startup_test_redis
    end

    def shutdown
      shutdown_test_redis
    end
  end

  should "add a uuid to job payload when pushed" do
    test_uuid = UUIDTools::UUID.random_create
    UUIDTools::UUID.expects(:random_create).returns(test_uuid)

    fake_payload = { 'payload' => 'blah' }

    Resque.push :my_queue, fake_payload

    popped = Resque.pop :my_queue

    assert_equal fake_payload.merge('uuid' => test_uuid.to_s), popped
  end

end
