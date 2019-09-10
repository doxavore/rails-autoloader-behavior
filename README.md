# Loader

This project is an example of Rails autoloading behavior.

Check [loader_test.rb](test/models/loader_test.rb) for details.

On Rails 5.2 (the `master` branch), changing the order of the tests (eg. changing `A)` to `C)`) results
in a test failure, showing the potentially surprising behavior.

On Rails 6.0 (the `rails6` branch), changing the order of the tests do not cause a test failure.

This behavior is not present in production environments where `config.eager_load = true`, but
can be a confusing case during development and test.
