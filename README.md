Narwhal on Nails
================

Narwhal engine which runs rhino under [nailgun](http://martiansoftware.com/nailgun/index.html).

Installation
------------

Run `make` from the root directory.
This will create symbolic links to the files and directories
  which comprise the actual rhino engine.

Environment
-----------

The environment variable NAILGUN_PORT will be used by nailgun to choose a port.
If this variable is not set, `nailgun` will use its default port, 2113.

This must be set consistently across invocations of narwhal
  in order for them to be able to access the same nailgun instance.

When narwhal-nail is invoked, it checks for a functioning nailgun on this port.
If it does not find one, it attempts to start one.
If it cannot start one, it tries to connect again, in case the nailgun was booting the first time.
If it fails this last attempt, it exits.

NAILGUN_RETRIES
NAILGUN_RETRY_PAUSE




The environment variable NAILGUN_START_WAIT determines how many seconds
  `narwhal-nail` waits to confirm that the nailgun server successfully launched.
It defaults to 3 seconds.
