resque-uuid
===========

ResqueUUID will assign random UUIDs to your Resque jobs so that they can be uniquely identified.

Usage
-----

```ruby
require 'resque'
require 'resque-uuid'

Resque::Plugins::ResqueUUID.enable!
```

UUIDs can be returned via:
* Resque::Job#uuid
* YourJobPayloadClass.uuid, if your payload class responds to .uuid= and .uuid

Additionally, your payload class can define an after_uuid_generated callback, which will be called with the newly-generated uuid and job args after the job is enqueued

```ruby
class MyJobClass

   def self.after_uuid_generated(uuid, *args)
    # do some record keeping or something
   end

end
```