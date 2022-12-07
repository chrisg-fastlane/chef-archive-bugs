# chef_archive_bugs

This cookbook is intended to demonstrate some buggy behaviour in Chef's `archive_file` resource.

These behaviours are:

* Archive unpacking fails silently if the destination directory has been created by a `directory` resource.
* Archive unpacking fails if the destination directory has been created by a `directory` resource and the `owner` or `group` property is provided.
* Archive unpacking with `owner` or `group` properties set is not idempotent.

This behaviour has only been noted on Red Hat Enterprise Linux release 8.4 (Ootpa).  It has not
been tested on any other platform.

## Run via JSON or recipes
There are JSON files provided for chef-solo runs, with equivalent recipes.
For example:

`$ sudo chef-solo -c run.rb -o 'chef_archive_bugs::good'`

`$ sudo chef-solo -c run.rb -j json/good.json`

### Recipes of note
`default.rb` - runs the archive unpacking such that it should work successfully on a new node. 
It also runs the archive unpacking with ownership properties to demonstrate lack of idempotence.

`good.rb` - runs the archive unpacking successfully because `archive_file` creates its own test directory.

`bad.rb` - runs the archive unpacking unsuccessfully because `archive_file` does not create its own test directory.

`make_testdir.rb` - Anytime this recipe is included in a run prior to unpacking, the unpacking will fail.

`unpack_archive_owner.rb` - Repeats unpacking to demonstrate lack of idempotence when `owner` or `group` are provided, even when they are for the current owner and group.

## Simple unpack test steps

Run the default recipe from scratch and it unpacks successfully.  Then run the `bad.rb` recipe, which will fail to unpack.  Then run the default recipe again and it will fail.

If you run the `good.rb` recipe it will succeed.  If you run the default recipe again it will succeed also.

## Simple ownership test
Simply run the default (or `unpack_archive_owner.rb`) recipe to see how repeated runs of the same `archive_file` resource are not up to date.

