require 'uuidtools'

module Resque
  module Plugins
    module ResqueUUID

      module ResqueExtensions
        def self.extended(extender)
          extender.send(:alias_method, :push_without_uuid, :push)
        end

        def push(queue, item)
          item['uuid'] = UUIDTools::UUID.random_create.to_s if item.respond_to?(:[]=)

          push_without_uuid(queue, item)
        end

      end

    end
  end
end
