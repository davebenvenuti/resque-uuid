require File.expand_path(File.join(File.dirname(__FILE__), "/../../test_helper"))

class FakeJobClass
  def self.old_after_fork_ran!
    @old_after_fork_ran = true
  end

  def self.old_after_fork_ran?
    !!@old_after_fork_ran
  end

  def self.uuid=(val)
    @uuid = val
  end

  def self.uuid
    @uuid
  end
end

class FakeJobClassNoUUID
  # no self.uuid= method defined
end

class ResqueUUIDTest < Test::Unit::TestCase

  should "extend Resque" do
    assert Resque.is_a?(Resque::Plugins::ResqueUUID::ResqueExtensions)
  end

  should "extend Resque::Job" do
    assert Resque::Job.include?(Resque::Plugins::ResqueUUID::JobExtensions)
  end

  should "define Resque.after_fork" do
    fake_job = Resque::Job.new :my_queue, 'some' => 'payload', 'uuid' => 'my_uuid', 'class' => 'FakeJobClass'

    Resque.after_fork.call(fake_job)

    # the old after_fork call is defined in test_helper
    assert fake_job.payload['old_after_fork'], "previously defined after_fork did not execute"
    assert_equal 'my_uuid', fake_job.uuid, "job uuid should be set from payload, but isn't"
    assert_equal 'my_uuid', FakeJobClass.uuid, "payload class uuid should be set from payload, but isn't"
  end

  should "gracefully handle payload classes with now uuid= method" do
    fake_job = Resque::Job.new :my_queue, 'some' => 'payload', 'uuid' => 'my_uuid', 'class' => 'FakeJobClassNoUUID'

    assert_nothing_raised do
      Resque.after_fork.call(fake_job)
    end
  end
end
