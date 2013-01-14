Narwhal on Nails
================

Narwhal engine which runs rhino under [nailgun](http://martiansoftware.com/nailgun/index.html).


Disclaimer
----------

Note that narwhal-nail doesn't do anything more intelligent than just
  running the rhino engine in nailgun.
In particular, note that no effort has been made
  to determine whether this is an appropriate thing to do.
As such, narwhal-nail should be considered even more experimental
  than nailgun itself.

Be aware that nailgun's near-complete lack of security consciousness would
  indicate against using this system for anything that should remain private.
The nailgun server will be instructed to listen only on the local interface.

It seems to work okay so far,
  as long as you don't mind devoting a sizable chunk of memory to it.
See the **Issues** section for more details.

The initial goal of being able to run interactive-ish commands
  like `tusk help` without having to wait for an actual narwhal to show up
  seems to have been met.


Installation
------------

Run `make` from the root directory.
This will create symbolic links to the files and directories
  which comprise the actual rhino engine.

Afterwards you can set your default engine to `nail`
  by editing your `narwhal.conf`.

Then just run a narwhal command.
The `narwhal-nail` Makefile will install dependencies and run setup.


Environment
-----------

The environment variable `NAILGUN_PORT`
  will be used by nailgun to choose a port.
If this variable is not set, `nailgun` will use its default port, 2113.

This must be set consistently across invocations of narwhal
  in order for them to be able to access the same nailgun instance.

When narwhal-nail is invoked, it checks for a functioning nailgun on this port.
If it does not find one, it attempts to start one.
If it cannot start one, it tries to connect again,
  in case the nailgun was booting the first time.
If it fails this last attempt, it exits.

The patience and persistence with which narwhal-nail attempts to
  connect to a freshly started server are controlled
  via the environment variables `NAILGUN_RETRIES` and `NAILGUN_RETRY_PAUSE`.
These default to, respectively, 1 second and 10.

Some debug output can be obtained by setting `NAILGUNNER_DEBUG`.

The environment variable NAILGUN_START_WAIT determines how many seconds
  `narwhal-nail` waits to confirm that the nailgun server successfully launched.
It defaults to 3 seconds.


Issues
------

Startup is not entirely reliable.
This may be related to the fact that
  java continues to run after tasks like $(tusk help) have appeared to complete.

I have no idea whether this setup is likely to work
  with multiple concurrent requests.

Memory consumption can rise quite quickly, especially when installing packages.
