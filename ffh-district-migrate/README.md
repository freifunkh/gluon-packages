ffh-district-migrate
====================

This package migrates a freifunk router to a `district` by
asking a webserver periodically every hour.

When you want to begin using the concept of districts in your
mesh, you normally have a lot of routers already configured
but without a configured district.

So conceptually there are now two choices:
1. Every router owner has to set the `district` manually
2. We migrate the routers centralized by an upgrade process

We decided to do the second choice and migrate the routers
using this helper package. It currently queries
`http://web.ffh.zone/migrate/${node_id}` and the webserver
returns the new district as plain ascii.

The script will be triggered hourly disregarding whether there
is already a district set. The minute is randomly chosen
at the first boot after upgrading.

Dependencies
------------

This package was designed to work without the
ffh-district-site-adjust package, so you can migrate routers
to a district without actually changing the `site.conf`.
So you can install this package and wait until every router
has properly configured a district value before you
activate the changes to the `site.conf` in the next firmware
release. So you don't destroy any meshes islands before the
the "district plan" is finally.

When the district was changed, there is normally some stuff to do, so other
packages can provide **executable** scripts in `/lib/gluon/district-changed.d/`
and do stuff when the district was changed. (e.g. adjust the `site.conf` and
reboot) But be aware, that these scripts **must** not reboot, when they are
called by luci (in config mode).

Pseudo Code
-----------

```
new_district = ask_webserver_for(node_id)

if curr_district == new_district:
   do nothing and exit!

else:
   set_district(new_district)

   execute(/lib/gluon/district-changed.sh)
```

Internals
---------

**Changing the district manually:**
``` shell
uci set gluon-node-info.district.current='leetfeld' # use the short identifier here
uci commit gluon-node-info
/lib/gluon/district-changed.sh
```

For the short identifiers, see [here](https://github.com/freifunkh/ffh-packages/blob/master/ffh-district-core/files/usr/lib/lua/gluon/districts.lua).

**Path of the installed cronjob file:**
``` shell
/usr/lib/micron.d/migrate-districts
```
