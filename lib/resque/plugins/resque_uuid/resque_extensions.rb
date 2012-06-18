require 'uuidtools'

module Resque
  module Plugins
    module ResqueUUID

      module ResqueExtensions
        include Resque::Helpers

        def self.extended(extender)
          extender.send(:alias_method, :push_without_uuid, :push)
        end

        def push(queue, item)
          item['uuid'] = UUIDTools::UUID.random_create.to_s if item.respond_to?(:[]=)

          ret = push_without_uuid(queue, item)

          # TODO (davebenvenuti 6/17/2012) the resque push method has no knowledge of the payload class, so this seems a bit sloppy.  However, I couldn't think of a better way to do it
          payload_class = constantize(item['class']) rescue nil
          payload_class.after_uuid_generated(item['uuid'], *item['args']) if payload_class && payload_class.respond_to?(:after_uuid_generated)

          ret
        end

      end

    end
  end
end
