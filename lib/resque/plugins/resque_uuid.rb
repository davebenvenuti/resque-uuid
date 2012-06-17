module Resque
  module Plugins

    module ResqueUUID

      def self.enable!
        Resque.send(:extend, Resque::Plugins::ResqueUUID::ResqueExtensions)
        Resque::Job.send(:include, Resque::Plugins::ResqueUUID::JobExtensions)

        old_after_fork = Resque.after_fork

        Resque.after_fork do |job|
          job.payload_class.uuid = job.payload['uuid'] if job.payload_class.respond_to?(:uuid=)
          old_after_fork.call(job) if old_after_fork
        end
      end
    end
  end
end
