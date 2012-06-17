require File.expand_path(File.join(File.dirname(__FILE__), "../../../test_helper"))

class JobExtensionsTest < Test::Unit::TestCase

  should "define uuid method for Resque::Job" do
    job = Resque::Job.new :my_queue, 'some' => 'payload', 'uuid' => 'some_unique_id'

    assert_equal 'some_unique_id', job.uuid
  end
end
