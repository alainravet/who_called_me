Before refactoring/changing code, you need to locate the tests that will use this code. who\_called\_me helps you track those usages.


## How to install :

    gem install who_called_me


## How to use :

### 1° call 'who\_called\_me' in the method you want to track.

    ..
    def foo
      who_called_me 		# <-- just insert this 
      ...
    end
    ..

### 2° run the tests / the application

When the tests/application exits, a report is printed in the console that looks like :


	---------------------------------------------------------------------------------------------------
	who_called_me report :
	======================

	+----------------------------
	| who_called_me
	+----------------------------

	/dev/my_project/spec/fixtures/foo_foo.rb:5:in `foo'
	  was called by :
	  .  /dev/my_project/spec/fixtures/foo.rb:8:in `bar'

	/dev/my_project/spec/fixtures/foo_foo.rb:6:in `foo'
	  was called by :
	  .  /dev/my_project/spec/fixtures/foo.rb:5:in `foo'
	  .    /dev/my_project/spec/fixtures/foo.rb:8:in `bar'

	---------------------------------------------------------------------------------------------------



== Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

== Copyright

Copyright (c) 2010 Alain Ravet. See LICENSE for details.
