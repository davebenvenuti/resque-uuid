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
