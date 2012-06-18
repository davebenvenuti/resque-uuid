require File.expand_path(File.join(File.dirname(__FILE__), "../../../test_helper"))

class FakeJobClass

  def self.after_uuid_generated(uuid, *args)
    @passed_uuid = uuid
    @passed_args = args
  end

  def self.passed_uuid
    @passed_uuid
  end

  def self.passed_args
    @passed_args
  end
end

class FakeJobClassNoUUIDCallback
end

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

  setup do
    # clear out resque queues each run
    Resque.redis.flushall
  end

  should "add a uuid to job payload when pushed" do
    test_uuid = UUIDTools::UUID.random_create
    UUIDTools::UUID.stubs(:random_create).returns(test_uuid)

    Resque.push :my_queue, { :payload => 'blah' }

    assert_equal({ 'payload' => 'blah', 'uuid' => test_uuid.to_s }, Resque.pop(:my_queue))
  end

  should "call after_uuid_generated method defined on payload class" do
    test_uuid = UUIDTools::UUID.random_create
    UUIDTools::UUID.stubs(:random_create).returns(test_uuid)

    Resque.push :my_queue, { :class => FakeJobClass.to_s, :args => [1,2,3] }

    assert_equal({ 'class' => FakeJobClass.to_s, 'args' => [1,2,3], 'uuid' => test_uuid.to_s }, Resque.pop(:my_queue))
    assert_equal test_uuid.to_s, FakeJobClass.passed_uuid
    assert_equal [1,2,3], FakeJobClass.passed_args
  end

  should "not call after_uuid_generated if payload class doesn't define one" do
    test_uuid = UUIDTools::UUID.random_create
    UUIDTools::UUID.stubs(:random_create).returns(test_uuid)

    assert_nothing_raised do
      Resque.push :my_queue, { :class => FakeJobClassNoUUIDCallback.to_s }
    end

    assert_equal({ 'class' => FakeJobClassNoUUIDCallback.to_s, 'uuid' => test_uuid.to_s }, Resque.pop(:my_queue))
  end

  should "not overwrite an existing uuid" do
    UUIDTools::UUID.expects(:random_create).never

    Resque.push :my_queue, { :class => FakeJobClassNoUUIDCallback.to_s, :uuid => 'my_unique_id' }

    assert_equal({ 'class' => FakeJobClassNoUUIDCallback.to_s, 'uuid' => 'my_unique_id' }, Resque.pop(:my_queue))
  end

  should "not call after_uuid_generated if a new uuid wasn't generated" do
    test_uuid = UUIDTools::UUID.random_create
    FakeJobClass.expects(:after_uuid_generated).never

    Resque.push :my_queue, { :class => FakeJobClassNoUUIDCallback.to_s, 'uuid' => 'my_unique_id' }
  end

end
