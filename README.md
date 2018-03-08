## Env

- ruby: ruby 2.3.6p384 (2017-12-14 revision 61254) [x86_64-darwin17]
- rails: https://github.com/rails/rails/blob/4-2-stable/version.rb

## Steps to reproduce

```
git clone git@github.com:sotayamashita/test-templarbit`
cd test-templarbit
# Add property_id and secret_key on config/initializers/templarbit.rb
bundle install --path vendor/bundle
bin/rake db:setup
bin/rails s
```

```
undefined method `set_header' for #<Rack::Response:0x00007fe485c72bf0>

vendor/bundle/ruby/2.3.0/gems/templarbit-2.0.0/lib/templarbit/middleware/contentsecuritypolicy.rb:18:in `call'
vendor/bundle/ruby/2.3.0/gems/templarbit-2.0.0/lib/templarbit/instance.rb:66:in `block in finalize'
vendor/bundle/ruby/2.3.0/gems/templarbit-2.0.0/lib/templarbit/instance.rb:65:in `each'
vendor/bundle/ruby/2.3.0/gems/templarbit-2.0.0/lib/templarbit/instance.rb:65:in `finalize'
/Users/sotayamashita/.rbenv/versions/2.3.6/lib/ruby/2.3.0/forwardable.rb:204:in `finalize'
vendor/bundle/ruby/2.3.0/gems/templarbit-2.0.0/lib/templarbit/integrations/rack.rb:17:in `call'
vendor/bundle/ruby/2.3.0/gems/rack-1.6.9/lib/rack/etag.rb:24:in `call'
vendor/bundle/ruby/2.3.0/gems/rack-1.6.9/lib/rack/conditionalget.rb:25:in `call'
vendor/bundle/ruby/2.3.0/gems/rack-1.6.9/lib/rack/head.rb:13:in `call'
vendor/bundle/ruby/2.3.0/gems/actionpack-4.2.10/lib/action_dispatch/middleware/params_parser.rb:27:in `call'
vendor/bundle/ruby/2.3.0/gems/actionpack-4.2.10/lib/action_dispatch/middleware/flash.rb:260:in `call'
vendor/bundle/ruby/2.3.0/gems/rack-1.6.9/lib/rack/session/abstract/id.rb:225:in `context'
vendor/bundle/ruby/2.3.0/gems/rack-1.6.9/lib/rack/session/abstract/id.rb:220:in `call'
vendor/bundle/ruby/2.3.0/gems/actionpack-4.2.10/lib/action_dispatch/middleware/cookies.rb:560:in `call'
vendor/bundle/ruby/2.3.0/gems/activerecord-4.2.10/lib/active_record/query_cache.rb:36:in `call'
vendor/bundle/ruby/2.3.0/gems/activerecord-4.2.10/lib/active_record/connection_adapters/abstract/connection_pool.rb:653:in `call'
vendor/bundle/ruby/2.3.0/gems/activerecord-4.2.10/lib/active_record/migration.rb:377:in `call'
vendor/bundle/ruby/2.3.0/gems/actionpack-4.2.10/lib/action_dispatch/middleware/callbacks.rb:29:in `block in call'
vendor/bundle/ruby/2.3.0/gems/activesupport-4.2.10/lib/active_support/callbacks.rb:88:in `__run_callbacks__'
vendor/bundle/ruby/2.3.0/gems/activesupport-4.2.10/lib/active_support/callbacks.rb:778:in `_run_call_callbacks'
vendor/bundle/ruby/2.3.0/gems/activesupport-4.2.10/lib/active_support/callbacks.rb:81:in `run_callbacks'
vendor/bundle/ruby/2.3.0/gems/actionpack-4.2.10/lib/action_dispatch/middleware/callbacks.rb:27:in `call'
vendor/bundle/ruby/2.3.0/gems/actionpack-4.2.10/lib/action_dispatch/middleware/reloader.rb:73:in `call'
vendor/bundle/ruby/2.3.0/gems/actionpack-4.2.10/lib/action_dispatch/middleware/remote_ip.rb:78:in `call'
vendor/bundle/ruby/2.3.0/gems/actionpack-4.2.10/lib/action_dispatch/middleware/debug_exceptions.rb:17:in `call'
vendor/bundle/ruby/2.3.0/gems/web-console-2.3.0/lib/web_console/middleware.rb:28:in `block in call'
vendor/bundle/ruby/2.3.0/gems/web-console-2.3.0/lib/web_console/middleware.rb:18:in `catch'
vendor/bundle/ruby/2.3.0/gems/web-console-2.3.0/lib/web_console/middleware.rb:18:in `call'
vendor/bundle/ruby/2.3.0/gems/actionpack-4.2.10/lib/action_dispatch/middleware/show_exceptions.rb:30:in `call'
vendor/bundle/ruby/2.3.0/gems/railties-4.2.10/lib/rails/rack/logger.rb:38:in `call_app'
vendor/bundle/ruby/2.3.0/gems/railties-4.2.10/lib/rails/rack/logger.rb:20:in `block in call'
vendor/bundle/ruby/2.3.0/gems/activesupport-4.2.10/lib/active_support/tagged_logging.rb:68:in `block in tagged'
vendor/bundle/ruby/2.3.0/gems/activesupport-4.2.10/lib/active_support/tagged_logging.rb:26:in `tagged'
vendor/bundle/ruby/2.3.0/gems/activesupport-4.2.10/lib/active_support/tagged_logging.rb:68:in `tagged'
vendor/bundle/ruby/2.3.0/gems/railties-4.2.10/lib/rails/rack/logger.rb:20:in `call'
vendor/bundle/ruby/2.3.0/gems/actionpack-4.2.10/lib/action_dispatch/middleware/request_id.rb:21:in `call'
vendor/bundle/ruby/2.3.0/gems/rack-1.6.9/lib/rack/methodoverride.rb:22:in `call'
vendor/bundle/ruby/2.3.0/gems/rack-1.6.9/lib/rack/runtime.rb:18:in `call'
vendor/bundle/ruby/2.3.0/gems/activesupport-4.2.10/lib/active_support/cache/strategy/local_cache_middleware.rb:28:in `call'
vendor/bundle/ruby/2.3.0/gems/rack-1.6.9/lib/rack/lock.rb:17:in `call'
vendor/bundle/ruby/2.3.0/gems/actionpack-4.2.10/lib/action_dispatch/middleware/static.rb:120:in `call'
vendor/bundle/ruby/2.3.0/gems/rack-1.6.9/lib/rack/sendfile.rb:113:in `call'
vendor/bundle/ruby/2.3.0/gems/railties-4.2.10/lib/rails/engine.rb:518:in `call'
vendor/bundle/ruby/2.3.0/gems/railties-4.2.10/lib/rails/application.rb:165:in `call'
vendor/bundle/ruby/2.3.0/gems/rack-1.6.9/lib/rack/lock.rb:17:in `call'
vendor/bundle/ruby/2.3.0/gems/rack-1.6.9/lib/rack/content_length.rb:15:in `call'
vendor/bundle/ruby/2.3.0/gems/rack-1.6.9/lib/rack/handler/webrick.rb:88:in `service'
/Users/sotayamashita/.rbenv/versions/2.3.6/lib/ruby/2.3.0/webrick/httpserver.rb:140:in `service'
/Users/sotayamashita/.rbenv/versions/2.3.6/lib/ruby/2.3.0/webrick/httpserver.rb:96:in `run'
/Users/sotayamashita/.rbenv/versions/2.3.6/lib/ruby/2.3.0/webrick/server.rb:314:in `block in start_thread'
```
