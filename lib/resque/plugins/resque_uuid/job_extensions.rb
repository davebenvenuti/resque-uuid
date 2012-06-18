module Resque
  module Plugins
    module ResqueUUID

      module JobExtensions
        def uuid
          self.payload[:uuid] || self.payload['uuid']
        end
      end

    end
  end
end
