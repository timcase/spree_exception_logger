SpreeExceptionLogger
====================

Introduction goes here.

Installation
------------

Add spree_exception_logger to your Gemfile:

```ruby
gem 'spree_exception_logger'
```

Bundle your dependencies and run the installation generator:

```shell
bundle
bundle exec rails g spree_exception_logger:install
```

copy the following in your application_controller.rb:

  include ExceptionLogger::ExceptionLoggable # loades the module
    rescue_from Exception, :with => :log_exception_handler


If you don't see the exceptions tab in admin then you may need to copy
the override into your main spree app dir


Testing
-------

Be sure to bundle your dependencies and then create a dummy test app for the specs to run against.

```shell
bundle
bundle exec rake test_app
bundle exec rspec spec
```

When testing your applications integration with this extension you may use it's factories.
Simply add this require statement to your spec_helper:

```ruby
require 'spree_exception_logger/factories'
```

Copyright (c) 2013 [name of extension creator], released under the New BSD License
