require 'uuidtools'

module Resque
  module Plugins
    module ResqueUUID

      module ResqueExtensions

        def self.extended(extender)
          extender.send(:alias_method, :push_without_uuid, :push)
        end

        def push(queue, item)
          uuid_generated = false

          old_uuid = (item[:uuid] || item['uuid']).to_s.strip

          # don't overwrite existing uuids
          if item.respond_to?(:[]=) && (old_uuid.size == 0)
            item[:uuid] = UUIDTools::UUID.random_create.to_s
            uuid_generated = true
          end


          ret = push_without_uuid(queue, item)

          # TODO (davebenvenuti 6/17/2012) the resque push method has no knowledge of the payload class, so this seems a bit sloppy.  However, I couldn't think of a better way to do it
          if uuid_generated
            payload_class = Util.constantize(item[:class] || item['class']) rescue nil
            payload_class.after_uuid_generated(item[:uuid], *item[:args]) if payload_class && payload_class.respond_to?(:after_uuid_generated)
          end

          ret
        end

      end

    end
  end
end
