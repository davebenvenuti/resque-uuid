class UtilTest < Test::Unit::TestCase

  should "constantize" do

    assert_equal Resque::Plugins::ResqueUUID::JobExtensions, Resque::Plugins::ResqueUUID::Util.constantize('Resque::Plugins::ResqueUUID::JobExtensions')

  end

end